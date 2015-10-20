//
//  LivesScreen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LivesScreen.h"
#import "LoaderHelper.h"
#import "TextBox.h"
#import "GameGui.h"
#import "AdButton.h"
#import "StatisticsTracker.h"
@interface LivesScreen(){
	NSMutableArray<TextBox*>* textBoxes;
	NSMutableArray<Button*>* buttons;
}
@end
@implementation LivesScreen
-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super initPosition:pos view:view];
	textBoxes = [NSMutableArray new];
	buttons = [NSMutableArray new];
	texture = [LoaderHelper loadTexture:@"liveScreen.png" enableMipmaps:false];
	[textBoxes addObject:[[TextBox alloc]initWithStringCentered:[NSString stringWithFormat:@"You have %d lives left",[StatisticsTracker sharedInstance].lives] x:0 y:0.6 color:WHITE size:1.5]];
	[buttons addObject:[[AdButton alloc]initWithPositionX:0.05 y:0 view:view]];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLives:) name:@"livesUpdated" object:nil];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	[buttons enumerateObjectsUsingBlock:^(GameGui* button,NSUInteger idx,BOOL *stop){
		[button touchesEnded:touches withEvent:event];
	}];
	
}
-(NSArray*)getAllButtons{
	
	
	return buttons;
}
-(NSArray *)getText{
	return textBoxes;
}
-(void)updateLives:(NSNumber *)lives{
	NSLog(@"Lives Updated");
	[self update];
}
-(void)update{
	[[textBoxes objectAtIndex:0] setString:[NSString stringWithFormat:@"You have %d lives left",[StatisticsTracker sharedInstance].lives]];
}

@end
