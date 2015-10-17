//
//  StatisticsTracker.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/18/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticsTracker : NSObject
+(StatisticsTracker*)sharedInstance;
@property (assign) int currentlevel;
@property (assign) int maxLevel;
@property int trees;
@property int lives;
@property NSDate* dateToFullyRecharge;
@property NSMutableArray<NSNumber*>* treeLevels;
-(void)saveData;
-(void)loadData;
-(void)setTrees:(int)trees forLevel:(int)level;
-(void)refillLives;
@end
