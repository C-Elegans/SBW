//
//  PauseScreen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "PauseScreen.h"
#import "LoaderHelper.h"
@implementation PauseScreen

-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super init];
	//playButton = [[MainScreenPlayButton alloc]initWithPositionX:-0.72 y:0 view:view];
	texture = [LoaderHelper loadTexture:@"mainScreen.png" enableMipmaps:false];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	//	[playButton touchesEnded:touches withEvent:event];
}
-(NSArray*)getButtons{
	//	NSArray* array = [[NSArray alloc] initWithObjects:playButton, nil];
	//	return array;
	return nil;
}
@end
