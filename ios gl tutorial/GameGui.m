//
//  GameGui.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"
#import "GameGuiProtectedMethods.h"

@implementation GameGui
-(id)initWithPositionX:(float)x y:(float)y view:(nullable UIView *)view{
    self = [super init];
    _x = x;
    _y = y;
    return self;
}

-(void)loadToBuffers:(const Vertex*)vertices vSize:(size_t)vsize indices:(const GLushort*)indices iSize:(size_t)isize objectName:(NSString*)objectName{
    _vaoID = [LoaderHelper loadToVBOS:vertices verticesSize:(int)vsize indices:indices indicesSize:(int)isize objectName:objectName];
    
    _numVertices = (int)isize/(int)sizeof(GLushort);
}
-(void)loadToTexture:(NSString*)fileName{
    _texture = [LoaderHelper loadTexture:fileName];
}

@end
