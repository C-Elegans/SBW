//
//  LeftButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LeftButton.h"
#import "GameGuiProtectedMethods.h"
const Vertex buttonVertices[] = {
    0,0,0,              0,1,
    0,0.1,0,            0,0,
    0.1,0.1,0,          1,0,
    0.1f,0.0f,0.0f,     1,1,
};
const GLushort buttonIndices[] = {
    0, 1, 2,
    2, 3, 0
};
@implementation LeftButton
-(id)initWithPositionX:(float)x y:(float)y{
    self = [super initWithPositionX:x y:y];
    [super loadToBuffers:&buttonVertices[0] vSize:sizeof(buttonVertices) indices:&buttonIndices[0] iSize:sizeof(buttonIndices)];
    [super loadToTexture:@"leftButton.png"];
    return self;
}
@end
