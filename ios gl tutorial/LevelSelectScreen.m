//
//  LevelSelectScreen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/18/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LevelSelectScreen.h"
#import "LoaderHelper.h"
#import "LevelLoader.h"
@interface LevelSelectScreen(){
	LevelLoader* _levelLoader;
}
@end
@implementation LevelSelectScreen

-(id)initPosition:(vec3)pos view:(UIView*) view loader:(LevelLoader*)levelLoader{
	self = [super initPosition:pos view:view];
	_levelLoader = levelLoader;
	texture = [LoaderHelper loadTexture:@"levelSelectScreen.png" enableMipmaps:false];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
}
-(NSArray*)getButtons{
	//NSArray* array = [[NSArray alloc] initWithObjects:playButton,levelButton, nil];
	return nil;
}
@end
