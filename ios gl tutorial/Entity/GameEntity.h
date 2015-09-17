//
//  GameEntity.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoaderHelper.h"
@interface GameEntity : NSObject{
    
}
@property float radius;
@property (nonatomic, getter=getTheta, setter=setTheta:) float theta;
@property GLuint vaoID;
@property GLuint texture;
@property int numVertices;
@property float textureDivisor;
@property vec2 textureOffset;
@property int rotation;
-(id)initRadius:(float)r theta:(float)t;
-(CGRect)getCollisionBox;
-(void)update;
-(BOOL)playerShouldCollide;
-(void)onCollisionWith:(GameEntity*)player;
@end
