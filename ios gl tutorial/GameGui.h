//
//  GameGui.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoaderHelper.h"
@interface GameGui : NSObject
@property GLuint vaoID;
@property GLuint texture;
@property int numVertices;
@property float x;
@property float y;

-(id)initWithPositionX:(float)x y:(float)y view:(nullable UIView *)view;
@end
