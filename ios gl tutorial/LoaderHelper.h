//
//  LoaderHelper.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "MathHelper.h"
typedef struct{
    GLuint vertexBuffer;
    GLuint indicesBuffer;
}VBOs;
@interface LoaderHelper : NSObject
+(VBOs)loadToVBOS:(const Vertex*)vertices verticesSize:(int)vSize indices:(const GLubyte*)indices indicesSize:(int)iSize;
+ (GLuint)setupTexture:(NSString *)fileName;
@end
