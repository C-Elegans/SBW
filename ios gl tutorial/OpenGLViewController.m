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
#import "LevelChangeScreen.h"
#import "Background.h"
#import "PauseButton.h"
#import "PauseScreen.h"
#import "StatisticsTracker.h"
static id theController = nil;

@interface OpenGLViewController (){
    GLuint _positionSlot;
    GLuint _colorSlot;
    MainScreen* mainScreen;
	LevelChangeScreen* changeScreen;
	PauseScreen* pauseScreen;
    MainShader* shader;
    GameShader* gameShader;
    GuiShader* guiShader;
    NSMutableArray* guiObjects;
    NSMutableArray* gameObjects;
	Player* player;
    GameInput* input;
    LevelLoader* levelLoader;
    Planet* planet;
	CFTimeInterval lastTimeStamp;
	NSLock* arrayLock;
	//Background* background;
}
@property (strong) GLKBaseEffect* effect;


@property (strong,nonatomic) EAGLContext *context;
@end
@implementation OpenGLViewController
@synthesize context = _context;
@synthesize currentLevel=_currentLevel;
@synthesize gameState=_gameState;
-(void)viewDidLoad{
    [super viewDidLoad];
    [LoaderHelper init];
    levelLoader = [[LevelLoader alloc] init];
	lastTimeStamp = CFAbsoluteTimeGetCurrent();
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
	self.preferredFramesPerSecond = 10;
    mainScreen = [[MainScreen alloc]initPosition:(vec3){0.0f,0.0f,0.0f} view:self.view];
	changeScreen = [[LevelChangeScreen alloc]initPosition:(vec3){0.0f,0.0f,0.0f} view:self.view];
	pauseScreen = [[PauseScreen alloc]initPosition:(vec3){0,0,0} view:self.view];
    shader = [[MainShader alloc]init];
	gameShader = [[GameShader alloc]init];
    guiShader = [[GuiShader alloc]init];
    gameObjects = [[NSMutableArray alloc]init];
    guiObjects = [[NSMutableArray alloc]init];
    
    planet =[[Planet alloc]initRadius:1 theta:0];
    player = [[Player alloc]initRadius:1 theta:0];
	
    //gameObjects = [levelLoader loadLevel:0];
    
    LeftButton* leftButton = [[LeftButton alloc]initWithPositionX:-.9 y:-.5 view:self.view];
    RightButton* rightButton = [[RightButton alloc]initWithPositionX:-.6 y:-.5 view:self.view];
    UpButton* upButton = [[UpButton alloc]initWithPositionX:.7 y:-.5 view:self.view];
	PauseButton* pauseButton =[[PauseButton alloc]initWithPositionX:.9 y:.85 view:self.view];
    [guiObjects addObject:leftButton];
    [guiObjects addObject:rightButton];
    [guiObjects addObject:upButton];
	[guiObjects addObject:pauseButton];
    input = [[GameInput alloc]init:player leftButton:leftButton rightButton:rightButton upButton:upButton pauseButton:pauseButton];
    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
    
	// self.currentLevel = [StatisticsTracker sharedInstance].currentlevel;
	self.currentLevel = 0;
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - GL Stuff
-(void)glkView:(nonnull GLKView *)view drawInRect:(CGRect)rect{
	[self updateFrameTime];
    glClearColor(0, 0, 0.1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
	
    switch (_gameState) {
        case MAIN:
			{
				glEnable(GL_BLEND);
				[shader start];
				glBindVertexArrayOES(mainScreen->vaoID);
				[shader enableAttribs];
				glActiveTexture(GL_TEXTURE0);
				glBindTexture(GL_TEXTURE_2D, mainScreen->texture);
				
				glDrawElements(GL_TRIANGLES, mainScreen->numVertices, GL_UNSIGNED_SHORT, 0);
				[shader disableAttribs];
				glBindVertexArrayOES(0);
				[shader stop];
			
				NSArray* buttons = [mainScreen getButtons];
				[guiShader start];
				[guiShader uploadScreenCorrection:self.view.frame.size];
				[guiShader uploadAlpha:1];
				glActiveTexture(GL_TEXTURE0);
				for(GameGui *gui in buttons){
	#ifdef DEBUG
					glPushGroupMarkerEXT(0,"rendering button");
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
			
			}
            break;
        case RUNNING:
			[arrayLock lock];
            if([gameObjects count] <1){
				[arrayLock unlock];
                break;
            }
            [gameShader start];
            [gameShader uploadHeightOffset:player.radius];
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
                [gameShader loadAnimation:entity.textureDivisor textureOffset:entity.textureOffset rotation:entity.rotation];
                if(entity.texture != previousTexture){
                    glBindTexture(GL_TEXTURE_2D, entity.texture);
                    previousTexture = entity.texture;
                }
                glDrawElements(GL_TRIANGLES, entity.numVertices, GL_UNSIGNED_SHORT, 0);
                
                [gameShader disableAttribs];
				[entity update];
                //glBindVertexArrayOES(0);
                #ifdef DEBUG
                glPopGroupMarkerEXT();
                #endif
            }
			[arrayLock unlock];
            //Render player
			[gameShader loadAnimation:player.textureDivisor textureOffset:player.textureOffset rotation:player.rotation];
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
			[guiShader uploadAlpha:0.1];
            glActiveTexture(GL_TEXTURE0);
            for(GameGui *gui in guiObjects){
                #ifdef DEBUG
                glPushGroupMarkerEXT(0, [[NSString stringWithFormat:@"Rendering Gui %lu", (unsigned long)[guiObjects indexOfObject:gui]]UTF8String]);
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
			[arrayLock lock];
            [player updatePosition:gameObjects];
			[arrayLock unlock];
            break;
		case LEVEL_CHANGE:
		{
				[shader start];
				glBindVertexArrayOES(changeScreen->vaoID);
				[shader enableAttribs];
				glActiveTexture(GL_TEXTURE0);
				glBindTexture(GL_TEXTURE_2D, changeScreen->texture);
				
				glDrawElements(GL_TRIANGLES, changeScreen->numVertices, GL_UNSIGNED_SHORT, 0);
				[shader disableAttribs];
				glBindVertexArrayOES(0);
				[shader stop];
				NSArray* buttons = [changeScreen getButtons];
				[guiShader start];
				[guiShader uploadScreenCorrection:self.view.frame.size];
				[guiShader uploadAlpha:1];
				glActiveTexture(GL_TEXTURE0);
				for(GameGui *gui in buttons){
					#ifdef DEBUG
					glPushGroupMarkerEXT(0,"rendering button");
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
		}
			break;
		case PAUSED:
		{
			[shader start];
			glBindVertexArrayOES(pauseScreen->vaoID);
			[shader enableAttribs];
			glActiveTexture(GL_TEXTURE0);
			glBindTexture(GL_TEXTURE_2D, pauseScreen->texture);
			
			glDrawElements(GL_TRIANGLES, pauseScreen->numVertices, GL_UNSIGNED_SHORT, 0);
			[shader disableAttribs];
			glBindVertexArrayOES(0);
			[shader stop];
			NSArray* buttons = [pauseScreen getButtons];
			[guiShader start];
			[guiShader uploadScreenCorrection:self.view.frame.size];
			[guiShader uploadAlpha:1];
			glActiveTexture(GL_TEXTURE0);
			for(GameGui *gui in buttons){
				#ifdef DEBUG
				glPushGroupMarkerEXT(0,"rendering button");
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
		
		break;
		}
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
		[mainScreen touchesEnded:touches withEvent:event];
	}else if(_gameState == LEVEL_CHANGE){
		[changeScreen touchesEnded:touches withEvent:event];
	}
	else{
        [input touchesEnded:touches withEvent:event];
    }
	switch (_gameState) {
  		case MAIN:
			[mainScreen touchesEnded:touches withEvent:event];break;
		case LEVEL_CHANGE:
			[changeScreen touchesEnded:touches withEvent:event]; break;
		case RUNNING:
			[input touchesEnded:touches withEvent:event];break;
		case PAUSED:
			[pauseScreen touchesEnded:touches withEvent:event];break;
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
		[StatisticsTracker sharedInstance].currentlevel = currentLevel;
		[arrayLock lock];
        gameObjects = [levelLoader loadLevel:_currentLevel];
        [gameObjects addObject:planet];
		[arrayLock unlock];
    }
    
}
-(void)aquireLock{
	
}
-(void)releaseLock{
	
}
-(int)currentLevel{
    @synchronized(self) {
        return _currentLevel;
    }
}
-(void)resetPlayerAndInput{
	player.radius = 1;
	player.theta = 0;
	[input reset];
}
-(void)setGameState:(GameState)gameState{
	@synchronized(self) {
		_gameState = gameState;
		switch (_gameState) {
			case MAIN:
    			self.preferredFramesPerSecond = 10; break;
			case RUNNING:
				self.preferredFramesPerSecond = 60; break;
			case LEVEL_CHANGE:
				self.preferredFramesPerSecond = 10; break;
			case PAUSED:
				self.preferredFramesPerSecond = 10; break;
	
		}
	}
}
-(GameState)gameState{
	return _gameState;
}

-(void)updateFrameTime{
	CFTimeInterval currentTime = CFAbsoluteTimeGetCurrent();
	_frameTime = currentTime - lastTimeStamp;
	lastTimeStamp = currentTime;
}

@end
