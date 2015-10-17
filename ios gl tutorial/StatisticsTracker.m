//
//  StatisticsTracker.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/18/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "StatisticsTracker.h"

@implementation StatisticsTracker
@synthesize currentlevel = _currentlevel;
-(id)init{
	self = [super init];
	[self loadData];
	return self;
}
+(StatisticsTracker*)sharedInstance{
	static StatisticsTracker* tracker = nil;
	static dispatch_once_t token;
	dispatch_once(&token, ^{
		tracker = [[self alloc] init];
	});
	return tracker;
}
-(void)saveData{
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_currentlevel] forKey:@"currentLevel"];
	[[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:_maxLevel] forKey:@"maxLevel"];
	[[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:_trees] forKey:@"trees"];
	[[NSUserDefaults standardUserDefaults]setObject:_treeLevels forKey:@"treeLevels"];
	[[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:_lives] forKey:@"lives"];
	[[NSUserDefaults standardUserDefaults]setObject:_dateToFullyRecharge forKey:@"dateToRecharge"];
}
-(void)loadData{
	if([[NSUserDefaults standardUserDefaults]objectForKey:@"maxLevel"]){
		_maxLevel = [[[NSUserDefaults standardUserDefaults]objectForKey:@"maxLevel"] integerValue];
		_currentlevel = [[[NSUserDefaults standardUserDefaults]objectForKey:@"currentLevel"] integerValue];
		_trees = [[[NSUserDefaults standardUserDefaults]objectForKey:@"trees"] integerValue];
		_lives = [[[NSUserDefaults standardUserDefaults]objectForKey:@"lives"] integerValue];
		_dateToFullyRecharge = [[NSUserDefaults standardUserDefaults]objectForKey:@"dateToRecharge"];
		
	}else{
		_maxLevel = 0;
		_currentlevel = 0;
		_trees = 0;
		_lives = 5;
		_dateToFullyRecharge = [NSDate date];
	}
	if([[NSUserDefaults standardUserDefaults]objectForKey:@"treeLevels"]){
		_treeLevels = [[NSUserDefaults standardUserDefaults]objectForKey:@"treeLevels"];
	}else{
		_treeLevels = [NSMutableArray new];
	}
	
}
-(void)setCurrentlevel:(int)currentlevel{
	@synchronized(self) {
		_currentlevel = currentlevel;
		if(currentlevel > _maxLevel){
			_maxLevel = currentlevel;
		}
	}
}
-(int)currentlevel{
	@synchronized(self) {
		return _currentlevel;
	}
}
-(void)setTrees:(int)trees forLevel:(int)level{
	if(level+1 > [_treeLevels count]){
		[_treeLevels addObject:[NSNumber numberWithInt:trees]];
		_trees += trees;
	}else{
		int lastTrees = [[_treeLevels objectAtIndex:level]integerValue];
		if(trees > lastTrees){
			[_treeLevels replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:trees]];
			_trees += trees-lastTrees;
		}
	}
}
-(void)refillLives{
	
}
@end
