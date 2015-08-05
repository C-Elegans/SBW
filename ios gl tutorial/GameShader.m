//
//  GameShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//
//
//  MainShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameShader.h"
#import "MathHelper.h"
@interface GameShader(){
    GLuint position_location;
    GLuint uv_location;
    
}
@end
@implementation GameShader
-(id)init{
    self = [super initFromVertexFile:@"gameVertexShader" fragmentFile:@"gameFragmentShader"];
    
    position_location = glGetAttribLocation(program, "position");
    uv_location = glGetAttribLocation(program, "inTexCoords");
    if(position_location == -1 || uv_location == -1){
        NSLog(@"Invalid Attrib Location!");
        exit(1);
    }
    
    return self;
}
-(void)start{
    glUseProgram(program);
    glEnableVertexAttribArray(position_location);
    glEnableVertexAttribArray(uv_location);
    glVertexAttribPointer(position_location, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    glVertexAttribPointer(uv_location, 2, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
}
-(void)stop{
    glDisableVertexAttribArray(position_location);
    glDisableVertexAttribArray(uv_location);
    glUseProgram(0);
}

@end
