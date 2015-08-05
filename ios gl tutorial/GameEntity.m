//
//  GameEntity.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntity.h"
#import "GameEntityProtectedMethods.h"
@implementation GameEntity
-(id)initRadius:(float)r theta:(float)t{
    self = [super init];
    _radius = r;
    _theta = t;
    return self;
}
-(void)loadToBuffers:(const Vertex*)vertices vSize:(size_t)vsize indices:(const GLubyte*)indices iSize:(size_t)isize{
    _buffers = [LoaderHelper loadToVBOS:vertices verticesSize:vsize indices:indices indicesSize:isize];
    _numVertices = isize/sizeof(GLubyte);
}
-(void)loadToTexture:(NSString*)fileName{
    _texture = [LoaderHelper setupTexture:fileName];
}
@end
