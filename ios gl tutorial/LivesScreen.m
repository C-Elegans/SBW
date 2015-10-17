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
#import "StatisticsTracker.h"
@interface LivesScreen(){
	NSMutableArray<TextBox*>* textBoxes;
}
@end
@implementation LivesScreen
-(id)initPosition:(vec3)pos view:(UIView*) view{
	self = [super initPosition:pos view:view];
	textBoxes = [NSMutableArray new];
	texture = [LoaderHelper loadTexture:@"liveScreen.png" enableMipmaps:false];
	[textBoxes addObject:[[TextBox alloc]initWithStringCentered:[NSString stringWithFormat:@"You have %d lives left",[StatisticsTracker sharedInstance].lives] x:0 y:0.6 color:WHITE size:1.5]];
	
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
}
-(NSArray*)getButtons{
	
	
	return nil;
}
-(NSArray *)getText{
	return textBoxes;
}
@end
