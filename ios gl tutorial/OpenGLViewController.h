//
//  OpenGLView.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
typedef enum{MAIN,RUNNING} GameState;
@interface OpenGLViewController : GLKViewController{
    
    
}
+(OpenGLViewController*)getController;
@property GameState gameState;
@end
