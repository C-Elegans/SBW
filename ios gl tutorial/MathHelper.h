//
//  MathHelper.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TWO_PI 6.283
typedef struct{
    float x;
    float y;
    float z;
}vec3;
typedef struct{
    float x;
    float y;
    float z;
    float r;
}vec4;
typedef struct{
    float x;
    float y;
}vec2;
typedef struct {
    float Position[3];
    float UV[2];
} Vertex;
@interface MathHelper : NSObject
+(float)vec3Dot:(vec3)vector1 vector2:(vec3)vector2;
@end
