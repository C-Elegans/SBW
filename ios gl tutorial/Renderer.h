//
//  Renderer.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/16/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameEntity.h"
#import "Screen.h"
#import "Player.h"
#import "GameGui.h"
#import "TextBox.h"
#import "Button.h"
@interface Renderer : NSObject
-(id)initView:(CGSize)size;
-(void)renderGameEntities:(NSArray<GameEntity*>*)entities;
-(void)renderStart;
-(void)renderScreen:(Screen*)screen;
-(void)renderPlayer:(Player*)player;
-(void)renderGuis:(NSArray<GameGui*>*)guis;
-(void)renderText:(NSArray<TextBox*>*)textBoxes;
-(void)renderButton:(NSArray<Button*>*)buttons;
@end
