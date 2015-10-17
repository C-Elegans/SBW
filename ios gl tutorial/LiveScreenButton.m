//
//  LiveScreenButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LiveScreenButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"

#define WIDTH 1.6
#define HEIGHT 0.35

@interface LiveScreenButton(){
	UIView* parentView;
	CGRect frameRect;
}
@end
@implementation LiveScreenButton
const Vertex liveButtonVertices[] = {
	0,0,0,              0,1,
	0,HEIGHT,0,            0,0,
	WIDTH,HEIGHT,0,          1,0,
	WIDTH,0.0f,0.0f,     1,1,
};
const GLushort liveButtonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&liveButtonVertices[0] vSize:sizeof(liveButtonVertices) indices:&liveButtonIndices[0] iSize:sizeof(liveButtonIndices) objectName:@"liveScreenButton"];
	[super loadToTexture:@"liveScreenButton.png"];
	frameRect = view.frame;
	
	parentView = view;
	return self;
}
-(CGRect)getBoundingBox{
	CGSize size = frameRect.size;
	float xDim = size.width;
	float yDim = size.height;
	float x = (self.x +1) *0.5;
	float y = (1-self.y) *0.5;
	//float offset = size.height/size.width;
	
	return CGRectMake(x*xDim, y*yDim, WIDTH*0.5*yDim, HEIGHT*0.5*yDim);
}

-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
	for(UITouch* touch in touches){
		if ([MathHelper point:[touch locationInView:parentView] insideBox:[self getBoundingBox]]) {
			[OpenGLViewController getController].gameState = AD;
		}
	}
	
}
@end
