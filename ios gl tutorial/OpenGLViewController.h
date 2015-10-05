//
//  OpenGLView.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "GameEntity.h"
#import "Bullet.h"
typedef enum{MAIN,RUNNING,LEVEL_CHANGE,PAUSED} GameState;
@interface OpenGLViewController : GLKViewController{
    
    
}
+(OpenGLViewController*)getController;
-(void)resetPlayerAndInput;
-(void)aquireLock;
-(void)releaseLock;
-(void)deleteObject:(GameEntity*)object;
-(void)flushObjects;
-(void)addBullet:(Bullet*)bullet;
-(void)deleteBullet:(Bullet*)bullet;
@property(readonly) float frameTime;
@property GameState gameState;
@property int currentLevel;
@property int trees;
@property float levelTime;
@end
