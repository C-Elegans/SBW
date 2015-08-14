//
//  MathHelper.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MathHelper.h"
#include <math.h>
@implementation MathHelper
+(float)vec3Dot:(vec3)vector1 vector2:(vec3)vector2{
    float sum = 0;
    sum += vector1.x *vector2.x;
    sum += vector1.y * vector2.y;
    sum += vector1.z * vector2.z;
    return sum;
}
+(BOOL)point:(CGPoint)point insideBox:(CGRect)box{
    if(point.x >= box.origin.x && point.x < (box.origin.x + box.size.width)){
        if(point.y <= box.origin.y && point.y > (box.origin.y - box.size.height)){
            return true;
        }
    }
    return false;
}

+(BOOL)valueInRange:(float)val min:(float)min max:(float)max{
    return (val > min)&&(val < max);
}
+(BOOL)rect:(CGRect)rect1 intersects:(CGRect)rect2{
    BOOL xOverlap = [MathHelper valueInRange:rect1.origin.x min:rect2.origin.x max:rect2.origin.x + rect2.size.width]||\
    [MathHelper valueInRange:rect2.origin.x min:rect1.origin.x max:rect1.origin.x + rect1.size.width];
    BOOL yOverlap = [MathHelper valueInRange:rect1.origin.y min:rect2.origin.y max:rect2.origin.y + rect2.size.height]||\
    [MathHelper valueInRange:rect2.origin.y min:rect1.origin.y max:rect1.origin.y + rect1.size.height];
    // bool xOverlap = valueInRange(A.x, B.x, B.x + B.width) ||
    //valueInRange(B.x, A.x, A.x + A.width);
    return xOverlap && yOverlap;
    
}
+(vec2)moveToUndoCollision:(CGRect)box1 withRect:(CGRect)box2{
    vec2 moveVector;
    BOOL xOverlap = [MathHelper valueInRange:box1.origin.x min:box2.origin.x max:box2.origin.x + box2.size.width]||\
    [MathHelper valueInRange:box2.origin.x min:box1.origin.x max:box1.origin.x + box1.size.width];
    BOOL yOverlap = [MathHelper valueInRange:box1.origin.y min:box2.origin.y max:box2.origin.y + box2.size.height]||\
    [MathHelper valueInRange:box2.origin.y min:box1.origin.y max:box1.origin.y + box1.size.height];
    if(xOverlap){
        float option1 = -((box1.origin.x +box1.size.width)-box2.origin.x);
        float option2 = -(box1.origin.x-(box2.origin.x + box2.size.width));
        moveVector.x = option2;
        if(fabsf(option1)<fabsf(option2)){
            moveVector.x = option1;
        }
    }
    if(yOverlap) {
        float option1 = -((box1.origin.y +box1.size.height)-box2.origin.y);
        float option2 = -(box1.origin.y-(box2.origin.y + box2.size.height));
        moveVector.y = option2;
        if(fabsf(option1)<fabsf(option2)){
            moveVector.y = option1;
        }
    }
    if(fabsf(moveVector.x)<fabsf(moveVector.y*3)){
        moveVector.y = 0;
    }
    else{
        moveVector.x = 0;
    }
    return moveVector;
}
@end
