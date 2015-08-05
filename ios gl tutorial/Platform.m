//
//  Platform.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/5/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Platform.h"
#import "GameEntityProtectedMethods.h"
@implementation Platform
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
-(id)initRadius:(float)r theta:(float)t{
    self = [super initRadius:r theta:t];
    [super loadToBuffers:&Vertices[0] vSize:sizeof(Vertices) indices:&Indices[0] iSize:sizeof(Indices)];
    [super loadToTexture:@"platform.png"];
    return self;
}
@end
