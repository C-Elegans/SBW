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
#import "TextBox.h"
#import "StatisticsTracker.h"
#import "Color.h"
@interface DeathScreen(){
	ChangeScreenMenuButton* menuButton;
	TryAgainButton* tryButton;
	TextBox* hearts;
}
@end
@implementation DeathScreen
-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super initPosition:pos view:view];
	menuButton = [[ChangeScreenMenuButton alloc]initWithPositionX:-.95 y:-0.4 view:view];
	tryButton = [[TryAgainButton alloc]initWithPositionX:0.05 y:-0.4 view:view];
	texture = [LoaderHelper loadTexture:@"deathScreen.png" enableMipmaps:false];
	hearts = [[TextBox alloc]initWithString:[NSString stringWithFormat:@"x%d",[StatisticsTracker sharedInstance].lives] x:0.1 y:-0.1 color:WHITE size:1];
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
-(NSArray *)getText{
	return [NSArray arrayWithObject:hearts];
}
@end
