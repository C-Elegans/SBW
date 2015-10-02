//
//  TextChar.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathHelper.h"
@interface TextChar : NSObject
@property char character;
@property vec2 position;
@property (readonly) vec2 offset;
@property GLuint texture;
@property GLuint vaoID;
@property int numVertices;
-(id)initWithChar:(char)character x:(float)x y:(float)y;
@end
