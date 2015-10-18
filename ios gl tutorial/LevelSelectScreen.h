//
//  LevelSelectScreen.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/18/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Screen.h"
#import "LevelLoader.h"
@interface LevelSelectScreen : Screen
-(id)initPosition:(vec3)pos view:(UIView*) view loader:(LevelLoader*)levelLoader;
@end
