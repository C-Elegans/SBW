//
//  MainShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MainShader.h"

@implementation MainShader
-(id)init{
    self = [super initFromVertexFile:@"vertexShader" fragmentFile:@"fragmentShader"];
    return self;
}
-(void)start{
    glUseProgram(program);
}
@end
