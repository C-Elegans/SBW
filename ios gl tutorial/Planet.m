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
    {{.5, 0, 0}, {0,1}},
    {{.5, TWO_PI/4, 0}, {1,1}},
    {{.5, TWO_PI/2, 0}, {1,0}},
    {{.5, 3*TWO_PI/4, 0}, {0,0}}
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
-(CGRect)getCollisionBox{
    return CGRectMake(0, 0, .5+[super radius], TWO_PI);
}
@end
