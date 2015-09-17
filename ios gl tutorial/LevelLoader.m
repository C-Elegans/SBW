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
@implementation LevelLoader
-(id)init{
    self = [super init];
    return self;
}

-(NSMutableArray*)loadLevel:(int)level{
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
    NSMutableArray* gameObjects = [[NSMutableArray alloc]init];
	[gameObjects addObject:[[Background alloc] initRadius:1 theta:0]];
    if(level<[allObjects count]){
        NSArray* platforms = [[allObjects objectAtIndex:level] objectForKey:@"platform"];
        for(int i=0;i<[platforms count];i+=2){
            float radius,theta;
            radius = [(NSNumber*)[platforms objectAtIndex:i] floatValue];
            theta = [(NSNumber*)[platforms objectAtIndex:i+1] floatValue];
            [gameObjects addObject:[[Platform alloc]initRadius:radius theta:theta]];
        }
		NSArray* doors = [[allObjects objectAtIndex:level] objectForKey:@"door"];
		float radius = [(NSNumber*)[doors objectAtIndex:0] floatValue];
		float theta = [(NSNumber*)[doors objectAtIndex:1] floatValue];
		[gameObjects addObject:[[Door alloc]initRadius:radius theta:theta]];
    }
    
    
    return gameObjects;
}
@end
