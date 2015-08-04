//
//  MathHelper.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MathHelper.h"

@implementation MathHelper
+(float)vec3Dot:(vec3)vector1 vector2:(vec3)vector2{
    float sum = 0;
    sum += vector1.x *vector2.x;
    sum += vector1.y * vector2.y;
    sum += vector1.z * vector2.z;
    return sum;
}
@end
