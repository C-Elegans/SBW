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
-(void)uploadTransformation:(float)x y:(float)y width:(float)width height:(float)height correction:(CGSize)correction;
-(void)uploadAlpha:(float)alpha;
@end
