//
//  TextRenderer.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "TextRenderer.h"
#import "TextShader.h"
#import "TextBox.h"
#import "TextChar.h"
#import "GuiShader.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>
#import "Color.h"
@interface TextRenderer(){
	TextShader* shader;
	//GuiShader* shader;
}
@end
@implementation TextRenderer
-(id)init{
	self = [super init];
	shader = [TextShader new];
	//shader = [GuiShader new];
	return self;
}
-(void)render:(NSArray<TextBox*>*)boxes view:(UIView*)view{
	[shader start];
	
	for (TextBox* box in boxes) {
		[shader uploadSize:box.size];
		for (TextChar* tc in [box getChars]) {
			[self renderTextChar:tc view:view color:box.color];
		}
	}
	[shader stop];
}
-(void)renderTextChar:(TextChar*)textChar view:(UIView*)view color:(vec4)color{
	glPushGroupMarkerEXT(0, "Rendering Char");
	glActiveTexture(GL_TEXTURE0);
	
	
	glBindVertexArrayOES(textChar.vaoID);
	[shader enableAttribs];
	
	[shader uploadObjectTransformation:textChar.position.x y:textChar.position.y];
	[shader uploadTexCoordOffset:textChar.offset];
	[shader uploadScreenCorrection:view.frame.size];
	[shader uploadColor:color];
	
	glBindTexture(GL_TEXTURE_2D, textChar.texture);
	glDrawElements(GL_TRIANGLES, textChar.numVertices, GL_UNSIGNED_SHORT, 0);
	[shader disableAttribs];
	glBindVertexArrayOES(0);
	
	
	
	
	glPopGroupMarkerEXT();
}
@end
