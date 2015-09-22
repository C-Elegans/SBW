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
}
-(void)loadData{
	if([[NSUserDefaults standardUserDefaults]objectForKey:@"maxLevel"]){
		_maxLevel = [[[NSUserDefaults standardUserDefaults]objectForKey:@"maxLevel"] integerValue];
		_currentlevel = [[[NSUserDefaults standardUserDefaults]objectForKey:@"currentLevel"] integerValue];
	}else{
		_maxLevel = 0;
		_currentlevel = 0;
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
@end
