//
//  BarShader.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/5/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Shader.h"

@interface BarShader : Shader
-(void)enableAttribs;
-(void)disableAttribs;
-(void)uploadObjectTransformation:(float)x y:(float)y;
-(void)uploadScreenCorrection:(CGSize)size;
-(void)uploadAlpha:(float)alpha;
@end
