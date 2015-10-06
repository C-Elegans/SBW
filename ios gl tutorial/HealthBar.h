//
//  HealthBar.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/5/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"
#import "Player.h"
@interface HealthBar : GameGui
-(void)render:(Player*)player;
@end
