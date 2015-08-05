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
#import "GameEntity.h"
#import "GameShader.h"
#import "Platform.h"
#import "Planet.h"
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES2/gl.h>

static id theController = nil;
@interface OpenGLViewController (){
    GLuint _positionSlot;
    GLuint _colorSlot;
    MainScreen* mainScreen;
    MainShader* shader;
    GameShader* gameShader;
    NSMutableArray* gameObjects;
}
@property (strong) GLKBaseEffect* effect;


@property (strong,nonatomic) EAGLContext *context;
@end
@implementation OpenGLViewController
@synthesize context = _context;

-(void)viewDidLoad{
    [super viewDidLoad];
    if(theController != nil && theController != self){
        NSLog(@"MORE THAN ONE CONTROLLER CREATED");
        exit(1);
    }
    theController = self;
    self.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if(!self.context){
        NSLog(@"Failed to create context");
        exit(1);
    }
    GLKView* view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    mainScreen = [[MainScreen alloc]initPosition:(vec3){0.0f,0.0f,0.0f}];
    shader = [[MainShader alloc]init];
    gameShader = [[GameShader alloc]init];
    gameObjects = [[NSMutableArray alloc]init];
    Platform* platform1 = [[Platform alloc]initRadius:1 theta:0];
    Platform* platform2 = [[Platform alloc]initRadius:1 theta:1.5];
    Planet* planet =[[Planet alloc]initRadius:.5 theta:0];
    [gameObjects addObject:platform1];
    [gameObjects addObject:platform2];
    [gameObjects addObject:planet];
    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - GL Stuff
-(void)glkView:(nonnull GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0, 0, 0.1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    switch (_gameState) {
        case MAIN:
            [shader start];
            glBindVertexArrayOES(mainScreen->vaoID);
            [shader enableAttribs];
            glActiveTexture(GL_TEXTURE0);
            glBindTexture(GL_TEXTURE_2D, mainScreen->texture);
            
            glDrawElements(GL_TRIANGLES, mainScreen->numVertices, GL_UNSIGNED_SHORT, 0);
            [shader disableAttribs];
            glBindVertexArrayOES(0);
            [shader stop];
            
            break;
        case RUNNING:
            if([gameObjects count] <1){
                break;
            }
            [gameShader start];
            [gameShader uploadHeightOffset:1.25];
            [gameShader uploadScreenCorrection:self.view.frame.size];
            for(id object in gameObjects){
                GameEntity* entity = (GameEntity*) object;
                
                glBindVertexArrayOES(entity.vaoID);
                [gameShader enableAttribs];
                
                [gameShader uploadObjectTransformation:entity.radius theta:entity.theta];
                
                glActiveTexture(GL_TEXTURE0);
                glBindTexture(GL_TEXTURE_2D, entity.texture);
                glDrawElements(GL_TRIANGLES, entity.numVertices, GL_UNSIGNED_SHORT, 0);
                
                [gameShader disableAttribs];
                glBindVertexArrayOES(0);
                [entity setTheta:entity.theta + 0.01];
                
            }
            [gameShader stop];
            break;
    }
    
    
}

-(void)update{
    
}
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    for(UITouch* touch in touches){
        if(_gameState == MAIN){
            CGPoint point = [touch locationInView:self.view];
            point.x = point.x /self.view.frame.size.width;
            point.y = point.y /self.view.frame.size.height;
            [mainScreen touchEnded:point];
        }
    }
}
+(OpenGLViewController*)getController{
    return theController;
}

@end
