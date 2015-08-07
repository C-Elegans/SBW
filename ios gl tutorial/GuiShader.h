//
//  GuiShader.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Shader.h"

@interface GuiShader : Shader
-(void)enableAttribs;
-(void)disableAttribs;
-(void)uploadObjectTransformation:(float)x y:(float)y;
-(void)uploadScreenCorrection:(CGSize)size;
@end
