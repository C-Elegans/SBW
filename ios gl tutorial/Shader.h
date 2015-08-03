//
//  Shader.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface Shader : NSObject{
    @protected GLuint program;
    
}
-(id)initFromVertexFile:(NSString*)vertFile fragmentFile:(NSString*) fragmentFile;
-(void)start;
-(void)stop;
@end
