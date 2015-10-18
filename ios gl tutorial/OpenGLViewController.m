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
#import "HealthBar.h"
#import "Bullet.h"
#import "TextRenderer.h"
#import "Color.h"
#import "HealthBar.h"
#import "Renderer.h"
#import "DeathScreen.h"
#import "LivesScreen.h"
#import "LevelSelectScreen.h"
static id theController = nil;

@interface OpenGLViewController (){
    GLuint _positionSlot;
    GLuint _colorSlot;
    MainScreen* mainScreen;
	LevelChangeScreen* changeScreen;
	PauseScreen* pauseScreen;
	DeathScreen* deathScreen;
	LivesScreen* livesScreen;
	LevelSelectScreen* selectScreen;
    NSMutableArray* guiObjects;
    NSMutableArray* gameObjects;
	Player* player;
    GameInput* input;
    LevelLoader* levelLoader;
    Planet* planet;
	CFTimeInterval lastTimeStamp;
	NSLock* arrayLock;
	NSMutableArray* objectsToDelete;
	NSMutableArray<Bullet*>* bullets;
	NSMutableArray<Bullet*>* bulletsToDelete;
	NSLock* bulletLock;
	NSMutableArray<TextBox*>* textBoxes;
	
	HealthBar* healthbar;
	Renderer* renderer;
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
	_levelTime = 0;
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
	deathScreen = [[DeathScreen alloc]initPosition:(vec3){0,0,0} view:self.view];
	livesScreen = [[LivesScreen alloc]initPosition:(vec3){0,0,0} view:self.view];
	selectScreen = [[LevelSelectScreen alloc]initPosition:(vec3){0,0,0} view:self.view loader:levelLoader];
    gameObjects = [[NSMutableArray alloc]init];
    guiObjects = [[NSMutableArray alloc]init];
	objectsToDelete = [NSMutableArray new];
	bullets = [NSMutableArray new];
	bulletsToDelete = [NSMutableArray new];
	textBoxes = [NSMutableArray new];
    planet =[[Planet alloc]initRadius:1 theta:0];
    player = [[Player alloc]initRadius:1 theta:0];
	bulletLock = [NSLock new];
    //gameObjects = [levelLoader loadLevel:0];
	arrayLock = [NSLock new];
    LeftButton* leftButton = [[LeftButton alloc]initWithPositionX:-.9 y:-.5 view:self.view];
    RightButton* rightButton = [[RightButton alloc]initWithPositionX:-.6 y:-.5 view:self.view];
    UpButton* upButton = [[UpButton alloc]initWithPositionX:.7 y:-.5 view:self.view];
	PauseButton* pauseButton =[[PauseButton alloc]initWithPositionX:.9 y:.85 view:self.view];
    [guiObjects addObject:leftButton];
    [guiObjects addObject:rightButton];
    [guiObjects addObject:upButton];
	[guiObjects addObject:pauseButton];
	healthbar = [[HealthBar alloc]initWithPositionX:0.6 y:0.9 view:view];
	//[guiObjects addObject:[[HealthBar alloc]initWithPositionX:-1 y:0.9 view:view]];
    input = [[GameInput alloc]init:player leftButton:leftButton rightButton:rightButton upButton:upButton pauseButton:pauseButton];
    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	[textBoxes addObject:[[TextBox alloc] initWithString:@"testing" x:-1 y:0.9 color:YELLOW size:1]];
	
	
	renderer = [[Renderer alloc]initView:self.view.frame.size];
	// self.currentLevel = [StatisticsTracker sharedInstance].currentlevel;
	self.currentLevel = 9;
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - GL Stuff
-(void)glkView:(nonnull GLKView *)view drawInRect:(CGRect)rect{
	[self updateFrameTime];
	TextBox* box = [textBoxes objectAtIndex:0];
	[box setString:[NSString stringWithFormat:@"%0.1fs",_levelTime]];
	[renderer renderStart];
	
    switch (_gameState) {
        case MAIN:
			{
			[renderer renderScreen:mainScreen];
			}
            break;
        case RUNNING:
			_levelTime += _frameTime;
			[arrayLock lock];
            if([gameObjects count] <1){
				[arrayLock unlock];
                break;
            }
			
			
            glActiveTexture(GL_TEXTURE0);
            
			[gameObjects addObjectsFromArray:bullets];
			[renderer renderGameEntities:gameObjects];
			
			
            //Render player
			
			[renderer renderPlayer:player];
            //Render Gui objects
			[renderer renderGuis:guiObjects];
			[renderer renderText:textBoxes];
            [input update];
			
			
			[healthbar render:player];
			[player update:gameObjects];
			[gameObjects removeObjectsInArray:objectsToDelete];
			[objectsToDelete removeAllObjects];
			[gameObjects removeObjectsInArray:bullets];
			
			[bullets removeObjectsInArray:bulletsToDelete];
			[bulletsToDelete removeAllObjects];
			
			for(Bullet* b in bullets){
				
					[b checkCollisions:gameObjects];
				
			}
			[gameObjects removeObjectsInArray:bullets];
			[bullets removeObjectsInArray:bulletsToDelete];
			[bulletsToDelete removeAllObjects];
			
			[arrayLock unlock];
			
            break;
		case LEVEL_CHANGE:
		{
			[renderer renderScreen:changeScreen];
		}
			break;
		case PAUSED:
		{
		[renderer renderScreen:pauseScreen];
		
		break;
		
		}
		case DEAD:{
			[renderer renderScreen:deathScreen];
			break;
		}
		case AD:
			[renderer renderScreen:livesScreen];
			break;
		case LEVEL_SELECT:
			[renderer renderScreen:selectScreen];
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
	if(_gameState == RUNNING){
		[input touchesEnded:touches withEvent:event];
	}else{
		[[self getScreenForState:_gameState] touchesEnded:touches withEvent:event];
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
		_levelTime = 0;
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
		if(_gameState == RUNNING){
			[self endLevel];
		}
		if(gameState == DEAD){
			[StatisticsTracker sharedInstance].lives --;
		}
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
			case DEAD:
				self.preferredFramesPerSecond = 10;	break;
			case AD:
				self.preferredFramesPerSecond = 10; break;
			case LEVEL_SELECT:
				self.preferredFramesPerSecond = 30; break;
		}
		[[self getScreenForState:_gameState] update];
	}
}
-(void)endLevel{
	dispatch_async(dispatch_get_main_queue(), ^{
	[arrayLock lock];
	[[StatisticsTracker sharedInstance ] setTrees:_trees forLevel:_currentLevel];
	[gameObjects removeObjectsInArray:bullets];
	[bullets removeAllObjects];
	[bulletsToDelete removeAllObjects];
	[arrayLock unlock];
	_trees = 0;
	});
}
-(GameState)gameState{
	return _gameState;
}

-(void)updateFrameTime{
	CFTimeInterval currentTime = CFAbsoluteTimeGetCurrent();
	_frameTime = currentTime - lastTimeStamp;
	lastTimeStamp = currentTime;
}
-(void)deleteObject:(GameEntity*)object{
	[objectsToDelete addObject:object];
}
-(void)flushObjects{
	if([objectsToDelete count]>0){
	dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[arrayLock lock];
		[gameObjects removeObjectsInArray:objectsToDelete];
		[objectsToDelete removeAllObjects];
		[arrayLock unlock];
	});
	}
	
}
-(void)addBullet:(Bullet *)bullet{
	[bulletLock lock];
	[bullets addObject:bullet];
	[bulletLock unlock];
}
-(void)deleteBullet:(Bullet *)bullet{
	[bulletLock lock];
	[bulletsToDelete addObject:bullet];
	[bulletLock unlock];
}
-(Screen*)getScreenForState:(GameState)state{
	switch (state) {
		case MAIN: return mainScreen; break;
		case RUNNING: return nil; break;
		case LEVEL_CHANGE: return changeScreen; break;
		case  PAUSED: return pauseScreen; break;
		case DEAD: return deathScreen; break;
		case AD: return livesScreen; break;
		case LEVEL_SELECT: return selectScreen; break;
}


@end
