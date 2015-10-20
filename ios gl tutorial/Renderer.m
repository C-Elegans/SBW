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
#import "FXAAShader.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
@interface Renderer(){
	MainShader* shader;
	GameShader* gameShader;
	GuiShader* guiShader;
	FXAAShader* fxaaShader;
	CGSize frameSize;
	TextRenderer* textRenderer;
	GLuint fxaaVAO;
	GLuint fxaaFrameBuffer;
	GLuint fxaaTexture;
	GLuint fxaaRenderBuffer;
	GLuint fxaaDepthBuffer;
	GLKView* view;
}
@end
@implementation Renderer
const Vertex fxaaVertices[] = {
	{{1, -1, 0}, {1,0}},
	{{1, 1, 0}, {1,1}},
	{{-1, 1, 0}, {0,1}},
	{{-1, -1, 0}, {0,0}}
};

const GLushort fxaaIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initView:(CGSize)size glkView:(GLKView *)glkView{
	self = [super init];
	frameSize = size;
	shader = [[MainShader alloc]init];
	gameShader = [[GameShader alloc]init];
	guiShader = [[GuiShader alloc]init];
	fxaaShader = [[FXAAShader alloc]init];
	textRenderer = [[TextRenderer alloc]init];
	fxaaVAO = [LoaderHelper loadToVBOS:fxaaVertices verticesSize:sizeof(fxaaVertices) indices:fxaaIndices indicesSize:sizeof(fxaaIndices) objectName:@"FXAA Screen"];
	view = glkView;
	
	
	glGenFramebuffers(1, &fxaaFrameBuffer);
	glBindFramebuffer(GL_FRAMEBUFFER, fxaaFrameBuffer);
	
	//create and bind renderbuffer
	glGenRenderbuffers(1, &fxaaRenderBuffer);
	glBindRenderbuffer(GL_RENDERBUFFER, fxaaRenderBuffer);
	glRenderbufferStorage(GL_RENDERBUFFER, GL_RGBA8_OES, frameSize.width*2, frameSize.height*2);
	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, fxaaRenderBuffer);
	//create and bind depth buffer
	/*glGenRenderbuffers(1, &fxaaDepthBuffer);
	 glBindRenderbuffer(GL_RENDERBUFFER, fxaaDepthBuffer);
	 glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, frameSize.width*2, frameSize.height*2);
	 glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, fxaaDepthBuffer);*/
	
	glGenTextures(1, &fxaaTexture);
	glBindTexture(GL_TEXTURE_2D, fxaaTexture);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA,  frameSize.width*2, frameSize.height*2, 0, GL_RGBA, GL_UNSIGNED_BYTE, NULL);
	
	
	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, fxaaTexture, 0);
	GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER) ;
	if(status != GL_FRAMEBUFFER_COMPLETE) {
		NSLog(@"failed to make complete framebuffer object %x", status);
	}
	
	glBindTexture(GL_TEXTURE_2D, 0);
	[view bindDrawable];
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
	
	//NSArray* buttons = [screen getButtons];
	[guiShader start];
	//[guiShader uploadScreenCorrection:frameSize];
	[guiShader uploadAlpha:1];
	glActiveTexture(GL_TEXTURE0);
	/*for(GameGui *gui in buttons){
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
	}*/
	[self renderButton:[screen getAllButtons]];
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
	
	[guiShader uploadAlpha:0.1];
	glActiveTexture(GL_TEXTURE0);
	for(GameGui *gui in guis){

		glBindVertexArrayOES(gui.vaoID);
		
		[guiShader enableAttribs];
		[guiShader uploadTransformation:gui.x y:gui.y width:1 height:1 correction:frameSize];
		glBindTexture(GL_TEXTURE_2D, gui.texture);
		glDrawElements(GL_TRIANGLES, gui.numVertices, GL_UNSIGNED_SHORT, 0);
		[guiShader disableAttribs];
		glBindVertexArrayOES(0);

	}
	
	[guiShader stop];
}
-(void)renderButton:(NSArray<Button *> *)buttons{
	NSMutableArray<TextBox*>* textBoxes = [NSMutableArray new];
	[guiShader start];
	//[guiShader uploadScreenCorrection:frameSize];
	[guiShader uploadAlpha:0.1];
	glActiveTexture(GL_TEXTURE0);
	for(Button *button in buttons){
		[textBoxes addObject:button.text];
		glBindVertexArrayOES(button.vaoID);
		
		[guiShader enableAttribs];
		[guiShader uploadTransformation:button.x y:button.y width:button.width height:button.height correction:frameSize];
		glBindTexture(GL_TEXTURE_2D, button.texture);
		glDrawElements(GL_TRIANGLES, button.numVertices, GL_UNSIGNED_SHORT, 0);
		[guiShader disableAttribs];
		glBindVertexArrayOES(0);
		
	}
	[guiShader stop];
	[self renderText:textBoxes];
}
-(void)renderText:(NSArray<TextBox *> *)textBoxes{
	[textRenderer render:textBoxes frame:frameSize];
}
-(void)bindFXAABuffer{
	
	glBindFramebuffer(GL_FRAMEBUFFER, fxaaFrameBuffer);
}
-(void)resolveFXAA{
	[view bindDrawable];
	[fxaaShader start];
	glBindVertexArrayOES(fxaaVAO);
	glBindTexture(GL_TEXTURE_2D, fxaaTexture);
	
	[fxaaShader enableAttribs];
	glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, 0);
	[fxaaShader disableAttribs];
	glBindTexture(GL_TEXTURE_2D, 0);
	[fxaaShader stop];
}
@end
