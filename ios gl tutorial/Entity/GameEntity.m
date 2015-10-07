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
@synthesize theta=_theta;
-(id)initRadius:(float)r theta:(float)t{
    self = [super init];
    _radius = r;
    _theta = t;
	_textureDivisor = 1;
	_textureOffset = (vec2){0,0};
	_rotation = 1;
    return self;
}
-(void)loadToBuffers:(const Vertex3D*)vertices vSize:(size_t)vsize indices:(const GLushort*)indices iSize:(size_t)isize objectName:(NSString*)objectName{
    _vaoID = [LoaderHelper loadToVBOS3D:vertices verticesSize:(int)vsize indices:indices indicesSize:(int)isize objectName:objectName];
    
    _numVertices = (int)isize/(int)sizeof(GLushort);
}
-(void)loadToTexture:(NSString*)fileName mipmapsEnabled:(BOOL)enableMipmaps{
    _texture = [LoaderHelper loadTexture:fileName enableMipmaps:enableMipmaps];
}
-(CGRect)getCollisionBox{
    return CGRectMake(0, 0, 0, 0);
}
-(float)getTheta{
    return _theta;
}
-(void)setTheta:(float)t{
    _theta = t;
    if(self.theta>TWO_PI){
        _theta -= TWO_PI;
    }
    if(self.theta <0){
        _theta += TWO_PI;
    }
}
-(void)update{
	
}
-(BOOL)playerShouldCollide{
	return YES;
}
-(void)onCollisionWith:(GameEntity *)player{
	
}
@end
