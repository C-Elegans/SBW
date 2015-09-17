//
//  Screen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Screen.h"

@implementation Screen
-(id)initPosition:(vec3)pos view:(nonnull UIView *)view{
	self = [super init ];
	position = pos;
	return self;
}
@end
