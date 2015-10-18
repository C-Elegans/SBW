//
//  LevelLoader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/14/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LevelLoader.h"
#import "Platform.h"
#import "Door.h"
#import "Background.h"
#import "JumpPad.h"
#import "Tree.h"
#import "Turret.h"
#import "Eyeball.h"
@interface LevelLoader(){
	NSArray* levels;
	dispatch_once_t token;
}
@end
@implementation LevelLoader
-(id)init{
    self = [super init];
	levels = [self loadLevelData];
    return self;
}

-(NSMutableArray*)loadLevel:(int)level{
    NSMutableArray* gameObjects = [[NSMutableArray alloc]init];
	[gameObjects addObject:[[Background alloc] initRadius:1 theta:0]];
    if(level<[levels count]){
        NSArray* platforms = [[levels objectAtIndex:level] objectForKey:@"Platform"];
        for(int i=0;i<[platforms count];i+=2){
            float radius,theta;
            radius = [(NSNumber*)[platforms objectAtIndex:i] floatValue];
            theta = [(NSNumber*)[platforms objectAtIndex:i+1] floatValue];
            [gameObjects addObject:[[Platform alloc]initRadius:radius theta:theta]];
        }
		NSArray* doors = [[levels objectAtIndex:level] objectForKey:@"Door"];
		float radius = [(NSNumber*)[doors objectAtIndex:0] floatValue];
		float theta = [(NSNumber*)[doors objectAtIndex:1] floatValue];
		[gameObjects addObject:[[Door alloc]initRadius:radius theta:theta]];
		NSArray* pads = [[levels objectAtIndex:level] objectForKey:@"JumpPad"];
		for(int i=0;i<[pads count];i+=2){
			float radius,theta;
			radius = [(NSNumber*)[pads objectAtIndex:i] floatValue];
			theta = [(NSNumber*)[pads objectAtIndex:i+1] floatValue];
			[gameObjects addObject:[[JumpPad alloc]initRadius:radius theta:theta]];
		}
		NSArray* trees = [[levels objectAtIndex:level] objectForKey:@"Tree"];
		for(int i=0;i<[trees count]; i+=2){
			float radius,theta;
			radius = [(NSNumber*)[trees objectAtIndex:i] floatValue];
			theta = [(NSNumber*)[trees objectAtIndex:i+1] floatValue];
			[gameObjects addObject:[[Tree alloc]initRadius:radius theta:theta]];
		}
		NSArray* turrets = [[levels objectAtIndex:level]objectForKey:@"Turret"];
		for(int i=0;i<[turrets count];i+= 3){
			float radius,theta,rotation;
			radius = [(NSNumber*)[turrets objectAtIndex:i] floatValue];
			theta = [(NSNumber*)[turrets objectAtIndex:i+1] floatValue];
			rotation =[(NSNumber*)[turrets objectAtIndex:i+2] floatValue];
			Turret* t = [[Turret alloc]initRadius:radius theta:theta];
			t.rotation = rotation;
			[gameObjects addObject:t];
		}
		NSArray* eyeballs = [[levels objectAtIndex:level] objectForKey:@"Eyeball"];
		for(int i=0;i<[eyeballs count]; i+=2){
			float radius,theta;
			radius = [(NSNumber*)[eyeballs objectAtIndex:i] floatValue];
			theta = [(NSNumber*)[eyeballs objectAtIndex:i+1] floatValue];
			[gameObjects addObject:[[Eyeball alloc]initRadius:radius theta:theta]];
		}
    }
	
	
    return gameObjects;
}
-(NSArray*)loadLevelData{
	NSString* levelPath = [[NSBundle mainBundle] pathForResource:@"levelData" ofType:@"json"];
	NSError* error;
	NSString* levelString = [[NSString alloc]initWithContentsOfFile:levelPath encoding:NSUTF8StringEncoding error:&error];
	NSData* jsonData = [levelString dataUsingEncoding:NSUTF8StringEncoding];
	
	NSArray* allObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
	if(error){
		NSLog(@"%@",[error localizedDescription]);
		NSLog(@"%@",levelString);
		NSLog(@"%@",jsonData);
	}
	return allObjects;
}
-(int)levelCount{
	return [levels count];
}
@end
