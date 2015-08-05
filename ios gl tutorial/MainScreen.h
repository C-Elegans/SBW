//
//  Entity.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathHelper.h"
#import "LoaderHelper.h"
#import <GLKit/GLKit.h>
typedef struct{
    float x;
    float y;
    float width;
    float height;
}Rectangle;
@interface MainScreen : NSObject{
    @public GLuint vaoID;
    @public GLuint texture;
    @public int numVertices;

    @protected
    vec3 position;
    
}
-(id)initPosition:(vec3)pos;
-(BOOL)touchEnded:(CGPoint)point;
@end
