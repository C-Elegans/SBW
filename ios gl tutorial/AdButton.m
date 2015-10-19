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

@implementation AdButton

-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Watch Ad" view:view];
	return self;
}

-(void)onClick{
	[((AppDelegate*)[[UIApplication sharedApplication] delegate]) watchV4VCAd];
}
@end
