//
//  OpenGLView.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "OpenGLViewController.h"
#import "Player.h"
#import "MainScreen.h"
#import "MainShader.h"
#import "GameEntity.h"
#import "GameShader.h"
#import "Platform.h"
#import "Planet.h"
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES2/gl.h>
#import "GameInput.h"
#import "GuiShader.h"
#import "LeftButton.h"
#import "RightButton.h"
#import "LevelLoader.h"
#undef DEBUG
static id theController = nil;

@interface OpenGLViewController (){
    GLuint _positionSlot;
    GLuint _colorSlot;
    MainScreen* mainScreen;
    MainShader* shader;
    GameShader* gameShader;
    GuiShader* guiShader;
    NSMutableArray* guiObjects;
    NSMutableArray* gameObjects;
    Player* player;
    GameInput* input;
    LevelLoader* levelLoader;
    Planet* planet;
}
@property (strong) GLKBaseEffect* effect;


@property (strong,nonatomic) EAGLContext *context;
@end
@implementation OpenGLViewController
@synthesize context = _context;
@synthesize currentLevel=_currentLevel;
-(void)viewDidLoad{
    [super viewDidLoad];
    [LoaderHelper init];
    levelLoader = [[LevelLoader alloc] init];
    
    GLKView *glkView = (GLKView*)self.view;
    glkView.drawableMultisample = GLKViewDrawableMultisample4X;
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
    guiShader = [[GuiShader alloc]init];
    gameObjects = [[NSMutableArray alloc]init];
    guiObjects = [[NSMutableArray alloc]init];
    
    planet =[[Planet alloc]initRadius:1 theta:0];
    player = [[Player alloc]initRadius:2 theta:1];
    //gameObjects = [levelLoader loadLevel:0];
    
    LeftButton* leftButton = [[LeftButton alloc]initWithPositionX:-.9 y:-.5 view:self.view];
    RightButton* rightButton = [[RightButton alloc]initWithPositionX:-.6 y:-.5 view:self.view];
    UpButton* upButton = [[UpButton alloc]initWithPositionX:.7 y:-.5 view:self.view];
    [guiObjects addObject:leftButton];
    [guiObjects addObject:rightButton];
    [guiObjects addObject:upButton];
    input = [[GameInput alloc]init:player leftButton:leftButton rightButton:rightButton upButton:upButton];
    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    CGRect left = [leftButton getBoundingBox];
    NSLog(@"LeftButton Bounding Box x: %f, y: %f, w:%f h:%f", left.origin.x,left.origin.y,left.size.width,left.size.height);
    self.currentLevel = 0;
    
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
            glActiveTexture(GL_TEXTURE0);
            GLuint previousTexture = -1;
            GLuint previousVAO = -1;
            for(id object in gameObjects){
                #ifdef DEBUG
                glPushGroupMarkerEXT(0, [[NSString stringWithFormat:@"Rendering object %lu",(unsigned long)[gameObjects indexOfObject:object]] UTF8String]);
                #endif
                GameEntity* entity = (GameEntity*) object;
                if(entity.vaoID != previousVAO){
                    glBindVertexArrayOES(entity.vaoID);
                    previousVAO = entity.vaoID;
                }
                [gameShader enableAttribs];
                
                [gameShader uploadObjectTransformation:entity.radius theta:entity.theta+(TWO_PI/4.0)-player.theta];
                
                if(entity.texture != previousTexture){
                    glBindTexture(GL_TEXTURE_2D, entity.texture);
                    previousTexture = entity.texture;
                }
                glDrawElements(GL_TRIANGLES, entity.numVertices, GL_UNSIGNED_SHORT, 0);
                
                [gameShader disableAttribs];
                //glBindVertexArrayOES(0);
                #ifdef DEBUG
                glPopGroupMarkerEXT();
                #endif
            }
            
            //Render player
            glPushGroupMarkerEXT(0, "Render Player");
            glBindVertexArrayOES(player.vaoID);
            [gameShader enableAttribs];
            [gameShader uploadObjectTransformation:player.radius theta:TWO_PI/4.0];
            glBindTexture(GL_TEXTURE_2D, player.texture);
            glDrawElements(GL_TRIANGLES, player.numVertices, GL_UNSIGNED_SHORT, 0);
            [gameShader disableAttribs];
            glBindVertexArrayOES(0);
            glPopGroupMarkerEXT();
            [gameShader stop];
            
            //Render Gui objects
            [guiShader start];
            [guiShader uploadScreenCorrection:self.view.frame.size];
            glActiveTexture(GL_TEXTURE0);
            for(GameGui *gui in guiObjects){
                #ifdef DEBUG
                glPushGroupMarkerEXT(0, [[NSString stringWithFormat:@"Rendering Gui %d", [guiObjects indexOfObject:gui]]UTF8String]);
                #endif
                glBindVertexArrayOES(gui.vaoID);
                [guiShader enableAttribs];
                [guiShader uploadObjectTransformation:gui.x y:gui.y];
                glBindTexture(GL_TEXTURE_2D, gui.texture);
                glDrawElements(GL_TRIANGLES, gui.numVertices, GL_UNSIGNED_SHORT, 0);
                [guiShader disableAttribs];
                glBindVertexArrayOES(0);
                #ifdef DEBUG
                glPopGroupMarkerEXT();
                #endif
            }
            [guiShader stop];
            [input update];
            [player updatePosition:gameObjects];
            
            break;
    }
    
    
}

-(void)update{
    
}
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if(_gameState == RUNNING){
        [input touchesBegan:touches withEvent:event];
    }
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if(_gameState == MAIN){
        for(UITouch* touch in touches){
        
            CGPoint point = [touch locationInView:self.view];
            NSLog(@"Touch x: %f y:%f",point.x,point.y);
            point.x = point.x /self.view.frame.size.width;
            point.y = point.y /self.view.frame.size.height;
            [mainScreen touchEnded:point];
        }
    }else{
        [input touchesEnded:touches withEvent:event];
    }
}
-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if(_gameState == RUNNING){
        [input touchesMoved:touches withEvent:event];
    }
}
+(OpenGLViewController*)getController{
    return theController;
}
-(void)setCurrentLevel:(int)currentLevel{
    @synchronized(self) {
        _currentLevel = currentLevel;
        gameObjects = [levelLoader loadLevel:_currentLevel];
        [gameObjects addObject:planet];
    }
    
}
-(int)currentLevel{
    @synchronized(self) {
        return _currentLevel;
    }
}

@end
