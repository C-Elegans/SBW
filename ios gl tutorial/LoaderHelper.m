//
//  LoaderHelper.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LoaderHelper.h"

@implementation LoaderHelper
+(VBOs)loadToVBOS:(const Vertex*)vertices verticesSize:(int)vSize indices:(const GLubyte*)indices indicesSize:(int)iSize{
    GLuint vertexBuffer,indicesBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, vSize, vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &indicesBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, iSize, indices, GL_STATIC_DRAW);
    NSLog(@"sizeof(indices): %lu",iSize);
    VBOs vbos;
    vbos.vertexBuffer = vertexBuffer;
    vbos.indicesBuffer = indicesBuffer;
    return vbos;
}
@end
