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
const Vertex platformVertices[] = {
    {{0, 0, 0}, {0,1}},
    {{0, .2, 0}, {1,1}},
    {{.2, .2, 0}, {1,0}},
    {{.2, 0, 0}, {0,0}}
};

const GLushort platformIndices[] = {
    0, 1, 2,
    2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
    self = [super initRadius:r theta:t];
    
    [super loadToBuffers:&platformVertices[0] vSize:sizeof(platformVertices) indices:&platformIndices[0] iSize:sizeof(platformIndices)];
    [super loadToTexture:@"platform.png"];
    return self;
}
-(CGRect)getCollisionBox{
    return CGRectMake(0+[super radius], 0+[super theta], .2, .2);
}
@end
