//
//  MathHelper.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define TWO_PI 6.283
#define GRAVITY 0.1
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
+(BOOL)point:(CGPoint)point insideBox:(CGRect)box;
+(BOOL)rect:(CGRect)rect1 intersects:(CGRect)rect2;
+(BOOL)valueInRange:(float)val min:(float)min max:(float)max;
+(vec2)moveToUndoCollision:(CGRect)box1 withRect:(CGRect)box2;
@end
