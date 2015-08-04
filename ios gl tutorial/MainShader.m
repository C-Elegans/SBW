//
//  MainShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MainShader.h"
#import "MathHelper.h"
@interface MainShader(){
    GLuint position_location;
    GLuint color_location;
}
@end
@implementation MainShader
-(id)init{
    self = [super initFromVertexFile:@"vertexShader" fragmentFile:@"fragmentShader"];
    
    position_location = glGetAttribLocation(program, "position");
    color_location = glGetAttribLocation(program, "sourceColor");
    if(position_location == -1 || color_location == -1){
        NSLog(@"Invalid Attrib Location!");
        exit(1);
    }
    
    return self;
}
-(void)start{
    glUseProgram(program);
    glEnableVertexAttribArray(position_location);
    glEnableVertexAttribArray(color_location);
    glVertexAttribPointer(position_location, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    glVertexAttribPointer(color_location, 4, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
}
-(void)stop{
    glDisableVertexAttribArray(position_location);
    glDisableVertexAttribArray(color_location);
    glUseProgram(0);
}
@end
