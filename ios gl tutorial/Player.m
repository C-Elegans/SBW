//
//  Player.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/6/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Player.h"
#import "GameEntityProtectedMethods.h"
@implementation Player
const Vertex playerVertices[] = {
    {{0, 0, 0}, {0,1}},
    {{0, .2, 0}, {1,1}},
    {{.2, .2, 0}, {1,0}},
    {{.2, 0, 0}, {0,0}}
};

const GLushort playerIndices[] = {
    0, 1, 2,
    2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
    self = [super initRadius:r theta:t];
    
    [super loadToBuffers:&playerVertices[0] vSize:sizeof(playerVertices) indices:&playerIndices[0] iSize:sizeof(playerIndices)];
    [super loadToTexture:@"player.png"];
    return self;
}
-(CGRect)getCollisionBox{
    return CGRectMake(0+[super radius], 0+[super theta], .2, .2);
}
@end
