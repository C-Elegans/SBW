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
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Try Again" view:view];
	return self;
}

-(void)onClick{
	[OpenGLViewController getController].gameState = RUNNING;
	
	[StatisticsTracker sharedInstance].lives--;
}
@end
