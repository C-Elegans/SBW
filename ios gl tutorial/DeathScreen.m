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
#import "LiveScreenButton.h"
#import "StatisticsTracker.h"
#import "Color.h"
@interface DeathScreen(){
	ChangeScreenMenuButton* menuButton;
	TryAgainButton* tryButton;
	LiveScreenButton* liveButton;
	TextBox* hearts;
}
@end
@implementation DeathScreen
-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super initPosition:pos view:view];
	menuButton = [[ChangeScreenMenuButton alloc]initWithPositionX:-.95 y:-0.4 view:view];
	tryButton = [[TryAgainButton alloc]initWithPositionX:0.05 y:-0.4 view:view];
	liveButton = [[LiveScreenButton alloc]initWithPositionX:0.05 y:-0.4 view:view];
	texture = [LoaderHelper loadTexture:@"deathScreen.png" enableMipmaps:false];
	hearts = [[TextBox alloc]initWithString:[NSString stringWithFormat:@"x%d",[StatisticsTracker sharedInstance].lives] x:0.1 y:-0.1 color:WHITE size:1];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLives:) name:@"livesUpdated" object:nil];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	int lives =[StatisticsTracker sharedInstance].lives;
	GameGui* button = (lives>0) ?tryButton:liveButton;
	[menuButton touchesEnded:touches withEvent:event];
	[button touchesEnded:touches withEvent:event];
}
-(NSArray*)getButtons{
	int lives =[StatisticsTracker sharedInstance].lives;
	GameGui* button = (lives>0) ?tryButton:liveButton;
	NSArray* array = [[NSArray alloc] initWithObjects:menuButton,button, nil];
	
	return array;
}
-(NSArray *)getText{
	return [NSArray arrayWithObject:hearts];
}
-(void)updateLives:(NSNumber *)lives{
	[self update];
}
-(void)update{
	hearts.string = [NSString stringWithFormat:@"x%d",[StatisticsTracker sharedInstance].lives];
}
@end
