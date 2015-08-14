//
//  RightrightButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "RightButton.h"
#import "GameGuiProtectedMethods.h"
@interface RightButton (){
    CGRect frameRect;
    UIView* parentView;
}
@end
@implementation RightButton
const Vertex rightButtonVertices[] = {
    0,0,0,              0,1,
    0,0.3,0,            0,0,
    0.3,0.3,0,          1,0,
    0.3f,0.0f,0.0f,     1,1,
};
const GLushort rightButtonIndices[] = {
    0, 1, 2,
    2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
    self = [super initWithPositionX:x y:y view:view];
    [super loadToBuffers:&rightButtonVertices[0] vSize:sizeof(rightButtonVertices) indices:&rightButtonIndices[0] iSize:sizeof(rightButtonIndices) objectName:@"rightButton"];
            [super loadToTexture:@"rightButton.png"];
    frameRect = view.frame;
    _buttonDown = false;
    parentView = view;
    return self;
}
-(CGRect)getBoundingBox{
    CGSize size = frameRect.size;
    float xDim = size.width;
    float yDim = size.height;
    float x = (self.x +1) *0.5;
    float y = (1-self.y) *0.5;
    //float offset = size.height/size.width;
    
    return CGRectMake(x*xDim, y*yDim, 0.3*0.5*yDim, 0.3*0.5*yDim);
}
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    for(UITouch* touch in touches){
        if ([MathHelper point:[touch locationInView:parentView] insideBox:[self getBoundingBox]]) {
            _buttonDown = true;
        }
    }
    
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    for(UITouch* touch in touches){
        if ([MathHelper point:[touch locationInView:parentView] insideBox:[self getBoundingBox]]) {
            _buttonDown = false;
        }
    }
    
}
-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    BOOL tempButtonDown = false;
    for(UITouch* touch in touches){
        if ([MathHelper point:[touch locationInView:parentView] insideBox:[self getBoundingBox]]) {
            tempButtonDown = true;
        }
    }
    _buttonDown = tempButtonDown;
}

@end
