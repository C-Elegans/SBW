//
//  AdButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "AdButton.h"
#import "GameGuiProtectedMethods.h"
#import <AdColony/AdColony.h>
#import "AppDelegate.h"
#define WIDTH 1.6
#define HEIGHT 0.35
@interface AdButton(){
	UIView* parentView;
	CGRect frameRect;
}
@end
@implementation AdButton
const Vertex adButtonVertices[] = {
	0,0,0,              0,1,
	0,HEIGHT,0,            0,0,
	WIDTH,HEIGHT,0,          1,0,
	WIDTH,0.0f,0.0f,     1,1,
};
const GLushort adButtonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&adButtonVertices[0] vSize:sizeof(adButtonVertices) indices:&adButtonIndices[0] iSize:sizeof(adButtonIndices) objectName:@"adButton"];
	[super loadToTexture:@"adButton.png"];
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
			[((AppDelegate*)[[UIApplication sharedApplication] delegate]) watchV4VCAd];
		}
	}
	
}
@end
