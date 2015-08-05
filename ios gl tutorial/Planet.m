//
//  Planet.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/5/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Planet.h"

#import "GameEntityProtectedMethods.h"
@implementation Planet
const Vertex planetVertices[] = {
    {{1, 0, 0}, {0,1}},
    {{1, TWO_PI/4, 0}, {1,1}},
    {{1, TWO_PI/2, 0}, {1,0}},
    {{1, 3*TWO_PI/4, 0}, {0,0}}
};

const GLushort planetIndices[] = {
    0, 1, 2,
    2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
    self = [super initRadius:r theta:t];
    [super loadToBuffers:&planetVertices[0] vSize:sizeof(planetVertices) indices:&planetIndices[0] iSize:sizeof(planetIndices)];
    
    [super loadToTexture:@"earth.png"];
    return self;
}
@end
