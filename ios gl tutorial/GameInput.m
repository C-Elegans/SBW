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
}
@end
@implementation GameInput
-(id)init:(nonnull Player *)theplayer leftButton:(nonnull LeftButton *)leftButton rightButton:(nonnull RightButton *)rightButton{
    self = [super init];
    player = theplayer;
    lButton = leftButton;
    rButton = rightButton;
    return self;
}
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [lButton touchesBegan:touches withEvent:event];
    [rButton touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [lButton touchesEnded:touches withEvent:event];
    [rButton touchesEnded:touches withEvent:event];
}
-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [lButton touchesMoved:touches withEvent:event];
    [rButton touchesMoved:touches withEvent:event];
}
-(void)update{
    if(lButton.buttonDown){
        player.theta -= 0.01;
    }
    if(rButton.buttonDown){
        player.theta += 0.01;
    }
}
@end
