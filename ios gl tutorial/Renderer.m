//
//  Renderer.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/16/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Renderer.h"
#import "Shader.h"
#import "MainShader.h"
#import "GameShader.h"
#import "GuiShader.h"
#import "Player.h"
#import "GameGui.h"
#import "TextRenderer.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
@interface Renderer(){
	MainShader* shader;
	GameShader* gameShader;
	GuiShader* guiShader;
	CGSize frameSize;
	TextRenderer* textRenderer;
}
@end
@implementation Renderer
-(id)initView:(CGSize)size{
	self = [super init];
	frameSize = size;
	shader = [[MainShader alloc]init];
	gameShader = [[GameShader alloc]init];
	guiShader = [[GuiShader alloc]init];
	textRenderer = [[TextRenderer alloc]init];
	return self;
}
-(void)renderStart{
	glClearColor(0, 0, 0, 1);
	glClear(GL_COLOR_BUFFER_BIT);
}
-(void)renderGameEntities:(NSMutableArray<GameEntity *> *)entities{
	[gameShader start];
	[gameShader uploadHeightOffset:[Player getPlayer].radius];
	[gameShader uploadScreenCorrection:frameSize];
	GLuint previousVAO = -1;
	GLuint previousTexture = -1;
	int i=0;
	for(GameEntity* entity in entities){
#ifdef DEBUG
		char str[128];
		sprintf(str, "Rendering Entity %d",i);
		glPushGroupMarkerEXT(0, str);
#endif
		if(entity.vaoID != previousVAO){
			glBindVertexArrayOES(entity.vaoID);
			previousVAO = entity.vaoID;
		}
		[gameShader enableAttribs];
		
		[gameShader uploadObjectTransformation:entity.radius theta:entity.theta+(TWO_PI/4.0)-[Player getPlayer].theta];
		[gameShader loadAnimation:entity.textureDivisor textureOffset:entity.textureOffset rotation:entity.rotation];
		[gameShader loadObjectRotation:entity.objectRotation];
		if(entity.texture != previousTexture){
			glBindTexture(GL_TEXTURE_2D, entity.texture);
			previousTexture = entity.texture;
		}
		glDrawElements(GL_TRIANGLES, entity.numVertices, GL_UNSIGNED_SHORT, 0);
		
		[gameShader disableAttribs];
		[entity update:entities];
		i++;
#ifdef DEBUG
		glPopGroupMarkerEXT();
#endif
	}
	[gameShader stop];
}
-(void)renderScreen:(Screen *)screen{
	glEnable(GL_BLEND);
	[shader start];
	glBindVertexArrayOES(screen->vaoID);
	[shader enableAttribs];
	glActiveTexture(GL_TEXTURE0);
	glBindTexture(GL_TEXTURE_2D, screen->texture);
	
	glDrawElements(GL_TRIANGLES, screen->numVertices, GL_UNSIGNED_SHORT, 0);
	[shader disableAttribs];
	glBindVertexArrayOES(0);
	[shader stop];
	
	NSArray* buttons = [screen getButtons];
	[guiShader start];
	[guiShader uploadScreenCorrection:frameSize];
	[guiShader uploadAlpha:1];
	glActiveTexture(GL_TEXTURE0);
	for(GameGui *gui in buttons){
#ifdef DEBUG
		glPushGroupMarkerEXT(0,"rendering button");
#endif
		glBindVertexArrayOES(gui.vaoID);
		[guiShader enableAttribs];
		[guiShader uploadObjectTransformation:gui.x y:gui.y];
		glBindTexture(GL_TEXTURE_2D, gui.texture);
		glDrawElements(GL_TRIANGLES, gui.numVertices, GL_UNSIGNED_SHORT, 0);
		[guiShader disableAttribs];
		glBindVertexArrayOES(0);
#ifdef DEBUG
		glPopGroupMarkerEXT();
#endif
	}
	
	[guiShader stop];
	[self renderText:screen.getText];
}
-(void)renderPlayer:(Player *)player{
	[gameShader start];
	[gameShader loadAnimation:player.textureDivisor textureOffset:player.textureOffset rotation:player.rotation];
	glPushGroupMarkerEXT(0, "Render Player");
	glBindVertexArrayOES(player.vaoID);
	[gameShader enableAttribs];
	[gameShader uploadObjectTransformation:player.radius theta:TWO_PI/4.0];
	glBindTexture(GL_TEXTURE_2D, player.texture);
	glDrawElements(GL_TRIANGLES, player.numVertices, GL_UNSIGNED_SHORT, 0);
	[gameShader disableAttribs];
	glBindVertexArrayOES(0);
	glPopGroupMarkerEXT();
	[gameShader stop];
}
-(void)renderGuis:(NSArray<GameGui *> *)guis{
	[guiShader start];
	[guiShader uploadScreenCorrection:frameSize];
	[guiShader uploadAlpha:0.1];
	glActiveTexture(GL_TEXTURE0);
	for(GameGui *gui in guis){

		glBindVertexArrayOES(gui.vaoID);
		
		[guiShader enableAttribs];
		[guiShader uploadObjectTransformation:gui.x y:gui.y];
		glBindTexture(GL_TEXTURE_2D, gui.texture);
		glDrawElements(GL_TRIANGLES, gui.numVertices, GL_UNSIGNED_SHORT, 0);
		[guiShader disableAttribs];
		glBindVertexArrayOES(0);

	}
	
	[guiShader stop];
}
-(void)renderText:(NSArray<TextBox *> *)textBoxes{
	[textRenderer render:textBoxes frame:frameSize];
}
@end
