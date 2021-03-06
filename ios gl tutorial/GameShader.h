//
//  GameShader.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shader.h"
#import "MathHelper.h"
@interface GameShader : Shader
-(void)uploadObjectTransformation:(float)r theta:(float)t;
-(void)enableAttribs;
-(void)disableAttribs;
-(void)uploadHeightOffset:(float)offset;
-(void)uploadScreenCorrection:(CGSize)size;
-(void)loadAnimation:(float)divisor textureOffset:(vec2)offset rotation:(int)rotation;
-(void)loadObjectRotation:(float)rotation;
@end
