//
//  PauseScreenResumeButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "PauseScreenResumeButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"
#define WIDTH 2.5
#define HEIGHT 0.35
@interface PauseScreenResumeButton (){
	CGRect frameRect;
	UIView* parentView;
	
}
@end
@implementation PauseScreenResumeButton
const Vertex resumeButtonVertices[] = {
	0,0,0,              0,1,
	0,HEIGHT,0,            0,0,
	WIDTH,HEIGHT,0,          1,0,
	WIDTH,0.0f,0.0f,     1,1,
};
const GLushort resumeButtonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Resume" view:view];
	return self;
}
-(void)onClick{
	[OpenGLViewController getController].gameState = RUNNING;
}
@end