//
//  PauseScreen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "PauseScreen.h"
#import "LoaderHelper.h"
#import "PauseScreenResumeButton.h"
@interface PauseScreen(){
	PauseScreenResumeButton* resumeButton;
}
@end
@implementation PauseScreen

-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super initPosition:pos view:view];
	resumeButton = [[PauseScreenResumeButton alloc]initWithPositionX:-0.72 y:-0.25 view:view];
	texture = [LoaderHelper loadTexture:@"pauseScreen.png" enableMipmaps:false];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	[resumeButton touchesEnded:touches withEvent:event];
}
-(NSArray<Button *> *)getAllButtons{
	NSArray* array = [[NSArray alloc] initWithObjects:resumeButton, nil];
	return array;
}

@end
