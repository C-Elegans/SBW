//
//  DeathScreen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/11/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "DeathScreen.h"
#import "LoaderHelper.h"
#import "TryAgainButton.h"
#import "ChangeScreenMenuButton.h"
@interface DeathScreen(){
	ChangeScreenMenuButton* menuButton;
	TryAgainButton* tryButton;
}
@end
@implementation DeathScreen
-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super initPosition:pos view:view];
	menuButton = [[ChangeScreenMenuButton alloc]initWithPositionX:-.95 y:-0.4 view:view];
	tryButton = [[TryAgainButton alloc]initWithPositionX:0.05 y:-0.4 view:view];
	texture = [LoaderHelper loadTexture:@"deathScreen.png" enableMipmaps:false];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	[menuButton touchesEnded:touches withEvent:event];
	[tryButton touchesEnded:touches withEvent:event];
}
-(NSArray*)getButtons{
	NSArray* array = [[NSArray alloc] initWithObjects:menuButton,tryButton, nil];
	
	return array;
}
@end
