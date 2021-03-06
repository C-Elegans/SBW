//
//  GameInput.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/6/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameInput.h"

@interface GameInput(){
    Player* player;
    LeftButton* lButton;
    RightButton* rButton;
    UpButton* uButton;
	PauseButton* pButton;
}
@end
@implementation GameInput
-(id)init:(nonnull Player *)theplayer leftButton:(nonnull LeftButton *)leftButton rightButton:(nonnull RightButton *)rightButton upButton:(nonnull UpButton*)upButton pauseButton:(nonnull PauseButton *)pauseButton{
    self = [super init];
    player = theplayer;
    lButton = leftButton;
    rButton = rightButton;
    uButton = upButton;
	pButton = pauseButton;
    return self;
}
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [lButton touchesBegan:touches withEvent:event];
    [rButton touchesBegan:touches withEvent:event];
    [uButton touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [lButton touchesEnded:touches withEvent:event];
    [rButton touchesEnded:touches withEvent:event];
    [uButton touchesEnded:touches withEvent:event];
	[pButton touchesEnded:touches withEvent:event];
}
-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [lButton touchesMoved:touches withEvent:event];
    [rButton touchesMoved:touches withEvent:event];
    [uButton touchesMoved:touches withEvent:event];
}
-(void)update{
    if(lButton.buttonDown){
		[player move:1];
    }
    else if(rButton.buttonDown){
		[player move:-1];
	}else{
		[player move:0];
	}
    if(uButton.buttonDown){
		[player jump:JUMP_HEIGHT];
    }
	
}
-(void)reset{
	lButton.buttonDown = false;
	rButton.buttonDown = false;
	uButton.buttonDown = false;
}
@end
