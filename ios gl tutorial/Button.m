//
//  Button.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/19/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Button.h"
#import "TextBox.h"
#import "GameGuiProtectedMethods.h"
@interface Button (){
	CGRect frameRect;
	UIView* parentView;
	
}
@end
@implementation Button
const Vertex buttonVertices[] = {
	0,0,0,              0,1,
	0,1,0,            0,0,
	1,1,0,          1,0,
	1,0.0f,0.0f,     1,1,
};
const GLushort buttonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y width:(float)width height:(float)height text:(NSString*)string view:(nonnull UIView *)view {
	_width = width;
	_height = height;
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&buttonVertices[0] vSize:sizeof(buttonVertices) indices:&buttonIndices[0] iSize:sizeof(buttonIndices) objectName:@"button"];
	[super loadToTexture:@"button1.png"];
	frameRect = view.frame;
	
	parentView = view;
	_text = [[TextBox alloc] initWithStringCentered:string x:self.x+(0.25*_width)  y:self.y+(0.25*_height)  color:BLACK size:1.5];
	return self;
}
-(CGRect)getBoundingBox{
	CGSize size = frameRect.size;
	float xDim = size.width;
	float yDim = size.height;
	float x = (self.x +1) *0.5;
	float y = (1-self.y) *0.5;
	//float offset = size.height/size.width;
	
	return CGRectMake(x*xDim, y*yDim, _width*0.5*yDim, _height*0.5*yDim);
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
	for(UITouch* touch in touches){
		if ([MathHelper point:[touch locationInView:parentView] insideBox:[self getBoundingBox]]) {
			[self onClick];
			
		}
	}
	
}
-(void)onClick{
	
}
@end
