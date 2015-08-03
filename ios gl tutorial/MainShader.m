//
//  MainShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MainShader.h"
@interface MainShader(){
    GLuint position_location;
    GLuint color_location;
}
@end
@implementation MainShader
-(id)init{
    self = [super initFromVertexFile:@"vertexShader" fragmentFile:@"fragmentShader"];
    
    position_location = glGetAttribLocation(program, "position");
    color_location = glGetAttribLocation(program, "colorSource");
    
    
    return self;
}
-(void)start{
    glUseProgram(program);
    glEnableVertexAttribArray(position_location);
    glEnableVertexAttribArray(color_location);
}
-(void)stop{
    glDisableVertexAttribArray(position_location);
    glDisableVertexAttribArray(color_location);
    glUseProgram(0);
}
@end
