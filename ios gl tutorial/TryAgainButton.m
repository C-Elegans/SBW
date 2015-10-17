//
//  TryAgainButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/16/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "TryAgainButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"
#import "StatisticsTracker.h"
#define WIDTH 1.6
#define HEIGHT 0.35
@interface TryAgainButton(){
	UIView* parentView;
	CGRect frameRect;
}
@end
@implementation TryAgainButton
const Vertex tryButtonVertices[] = {
	0,0,0,              0,1,
	0,HEIGHT,0,            0,0,
	WIDTH,HEIGHT,0,          1,0,
	WIDTH,0.0f,0.0f,     1,1,
};
const GLushort tryButtonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&tryButtonVertices[0] vSize:sizeof(tryButtonVertices) indices:&tryButtonIndices[0] iSize:sizeof(tryButtonIndices) objectName:@"tryAgainButton"];
	[super loadToTexture:@"tryAgainButton.png"];
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
			
			[OpenGLViewController getController].gameState = RUNNING;
			
			[StatisticsTracker sharedInstance].lives--;
		}
	}
	
}
@end
