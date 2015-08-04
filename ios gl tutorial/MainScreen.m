//
//  Entity.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MainScreen.h"


const Vertex Vertices[] = {
    {{1, -1, 0}, {1,1}},
    {{1, 1, 0}, {1,0}},
    {{-1, 1, 0}, {0,0}},
    {{-1, -1, 0}, {0,1}}
};

const GLubyte Indices[] = {
    0, 1, 2,
    2, 3, 0
};
@implementation MainScreen
-(id)initPosition:(vec3)pos{
    self = [super init];
    position = pos;
    buffers = [LoaderHelper loadToVBOS:&Vertices[0] verticesSize:sizeof(Vertices) indices:&Indices[0] indicesSize:sizeof(Indices)];
    numVertices = sizeof(Indices)/sizeof(Indices[0]);
    texture = [LoaderHelper setupTexture:@"mainScreen.png"];
    return self;
}

@end
