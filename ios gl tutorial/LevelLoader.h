//
//  LevelLoader.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/14/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"

@interface LevelLoader : GameGui
-(NSMutableArray*)loadLevel:(int)level;
@end
