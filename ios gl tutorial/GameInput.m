//
//  GameInput.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/6/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameInput.h"
@interface GameInput(){
    float* globalRotation;
}
@end
@implementation GameInput
-(id)init:(__nonnull float*)g{
    self = [super init];
    globalRotation = g;
    return self;
}
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    *globalRotation += 0.1;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
}
@end
