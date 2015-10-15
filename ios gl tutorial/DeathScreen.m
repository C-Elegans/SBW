//
//  DeathScreen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/11/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "DeathScreen.h"
#import "LoaderHelper.h"
@implementation DeathScreen
-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super initPosition:pos view:view];
	//resumeButton = [[PauseScreenResumeButton alloc]initWithPositionX:-0.72 y:-0.25 view:view];
	texture = [LoaderHelper loadTexture:@"pauseScreen.png" enableMipmaps:false];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	//[resumeButton touchesEnded:touches withEvent:event];
}
-(NSArray*)getButtons{
	//NSArray* array = [[NSArray alloc] initWithObjects:resumeButton, nil];
	NSArray* array = nil;
	return array;
}
@end
