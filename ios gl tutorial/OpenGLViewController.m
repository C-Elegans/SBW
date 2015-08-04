//
//  OpenGLView.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "OpenGLViewController.h"
#import "GLSprite.h"
#import "MainScreen.h"
#import "MainShader.h"
@interface OpenGLViewController (){
    GLuint _positionSlot;
    GLuint _colorSlot;
    MainScreen* entity;
    MainShader* shader;
}
@property (strong) GLKBaseEffect* effect;


@property (strong,nonatomic) EAGLContext *context;
@end
@implementation OpenGLViewController
@synthesize context = _context;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if(!self.context){
        NSLog(@"Failed to create context");
        exit(1);
    }
    GLKView* view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    entity = [[MainScreen alloc]initPosition:(vec3){0.0f,0.0f,0.0f}];
    shader = [[MainShader alloc]init];
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - GL Stuff
-(void)glkView:(nonnull GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0, 0.45f, 0.25f, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBindBuffer(GL_ARRAY_BUFFER, entity->buffers.vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, entity->buffers.indicesBuffer);
    [shader start];
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, entity->texture);
    glDrawElements(GL_TRIANGLES, entity->numVertices, GL_UNSIGNED_BYTE, 0);
    
    [shader stop];
    
}
-(void)update{
    
}

@end
