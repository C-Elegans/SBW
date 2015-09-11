//
//  ChangeScreenNextButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/11/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "ChangeScreenNextButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"
#define WIDTH 1.6
#define HEIGHT 0.35

@interface ChangeScreenNextButton (){
	CGRect frameRect;
	UIView* parentView;
	
}
@end
@implementation ChangeScreenNextButton
const Vertex nextButtonVertices[] = {
	0,0,0,              0,1,
	0,HEIGHT,0,            0,0,
	WIDTH,HEIGHT,0,          1,0,
	WIDTH,0.0f,0.0f,     1,1,
};
const GLushort nextButtonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&nextButtonVertices[0] vSize:sizeof(nextButtonVertices) indices:&nextButtonIndices[0] iSize:sizeof(nextButtonIndices) objectName:@"nextButton"];
	[super loadToTexture:@"nextButton.png"];
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
			[OpenGLViewController getController].currentLevel++;
			[[OpenGLViewController getController] resetPlayerAndInput];
			[OpenGLViewController getController].gameState = RUNNING;
		}
	}
	
}
@end