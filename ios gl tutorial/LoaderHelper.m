//
//  LoaderHelper.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LoaderHelper.h"
#import <OpenGLES/ES2/glext.h>
#import <UIKit/UIKit.h>
@implementation LoaderHelper
static NSMutableDictionary* textureDict;
static NSMutableDictionary* vaoDict;
+(void)init{
    textureDict = [[NSMutableDictionary alloc]init];
    vaoDict = [[NSMutableDictionary alloc]init];
}
+(GLuint)loadVertices:(const Vertex*)vertices verticesSize:(int)vSize indices:(const GLushort*)indices indicesSize:(int)iSize{
    GLuint vaoid;
    glGenVertexArraysOES(1, &vaoid);
    glBindVertexArrayOES(vaoid);
    GLuint vertexBuffer,indicesBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, vSize, vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &indicesBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, iSize, indices, GL_STATIC_DRAW);
    
    
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
    glDisableVertexAttribArray(vaoid);
    glBindVertexArrayOES(0);
    return vaoid;
    
    
    
}
+(GLuint)loadVertices3D:(const Vertex3D*)vertices verticesSize:(int)vSize indices:(const GLushort*)indices indicesSize:(int)iSize{
	GLuint vaoid;
	glGenVertexArraysOES(1, &vaoid);
	glBindVertexArrayOES(vaoid);
	GLuint vertexBuffer,indicesBuffer;
	glGenBuffers(1, &vertexBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
	glBufferData(GL_ARRAY_BUFFER, vSize, vertices, GL_STATIC_DRAW);
	
	glGenBuffers(1, &indicesBuffer);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesBuffer);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, iSize, indices, GL_STATIC_DRAW);
	
	
	glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex3D), 0);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex3D), (GLvoid*) (sizeof(float) * 3));
	glDisableVertexAttribArray(vaoid);
	glBindVertexArrayOES(0);
	return vaoid;
	
	
	
}
+(GLuint)loadToVBOS:(const Vertex *)vertices verticesSize:(int)vSize indices:(const GLushort *)indices indicesSize:(int)iSize objectName:(NSString*)objectName{
    NSNumber* vaoID = [vaoDict objectForKey:objectName];
    if(vaoID == nil){
        vaoID = [NSNumber numberWithInt:[LoaderHelper loadVertices:vertices verticesSize:vSize indices:indices indicesSize:iSize]];
        [vaoDict setObject:vaoID forKey:objectName];
    }
    return (GLuint)[vaoID integerValue];
}
+(GLuint)loadToVBOS3D:(const Vertex3D *)vertices verticesSize:(int)vSize indices:(const GLushort *)indices indicesSize:(int)iSize objectName:(NSString*)objectName{
	NSNumber* vaoID = [vaoDict objectForKey:objectName];
	if(vaoID == nil){
		vaoID = [NSNumber numberWithInt:[LoaderHelper loadVertices3D:vertices verticesSize:vSize indices:indices indicesSize:iSize]];
		[vaoDict setObject:vaoID forKey:objectName];
	}
	return (GLuint)[vaoID integerValue];
}
+ (GLuint)setupTexture:(NSString *)fileName enableMipmaps:(BOOL)mipmapEnabled{
    // 1
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
    
    // 2
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    // 3
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    
    // 4
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    
    
    
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
	if(mipmapEnabled){
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP_HINT, GL_NICEST);
		glGenerateMipmap(GL_TEXTURE_2D);
	}else{
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		//glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP_HINT, GL_NICEST);
		//glGenerateMipmap(GL_TEXTURE_2D);
	}
	//glGenerateMipmap(GL_TEXTURE_2D);
    free(spriteData);
    return texName;
}
+(GLuint)loadTexture:(NSString *)fileName enableMipmaps:(BOOL)mipmapsEnabled{
    NSNumber *texture = [textureDict objectForKey:fileName];
    if(texture == nil){
        texture = [NSNumber numberWithInt:[LoaderHelper setupTexture:fileName enableMipmaps:mipmapsEnabled]];
        [textureDict setObject:texture forKey:fileName];
    }
    return (GLuint)[texture intValue];
}
@end
