//
//  TextShader.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Shader.h"
#import "MathHelper.h"
@interface TextShader : Shader
-(id)init;
-(void)enableAttribs;
-(void)disableAttribs;
-(void)uploadObjectTransformation:(float)x y:(float)y;
-(void)uploadScreenCorrection:(CGSize)size;
-(void)uploadTexCoordOffset:(vec2)offset;
-(void)uploadColor:(vec4)color;
@end
