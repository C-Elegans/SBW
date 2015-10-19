//
//  LevelSelectButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/18/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LevelSelectButton.h"
#import "OpenGLViewController.h"
#import "GameGuiProtectedMethods.h"
#define WIDTH 1.6
#define HEIGHT 0.35

@interface LevelSelectButton(){
	UIView* parentView;
	CGRect frameRect;
}
@end
@implementation LevelSelectButton

-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Level Select" view:view];
	return self;
}

-(void)onClick{
	[OpenGLViewController getController].gameState = LEVEL_SELECT;
}

@end

