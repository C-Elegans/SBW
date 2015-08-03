//
//  OpenGLView.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "OpenGLViewController.h"
#import "GLSprite.h"
@interface OpenGLViewController (){
    GLuint _positionSlot;
    GLuint _colorSlot;
    
}
@property (strong) GLKBaseEffect* effect;
@property (strong) GLSprite* sprite;

@property (strong,nonatomic) EAGLContext *context;
@end
@implementation OpenGLViewController
@synthesize context = _context;
typedef struct{
    float postion[3];
    float color[4];
}Vertex;
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
    
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - GL Stuff
-(void)glkView:(nonnull GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0, 0.45f, 0.25f, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
}
-(void)update{
    
}

@end
