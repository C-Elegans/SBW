//
//  GameEntity.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoaderHelper.h"
@interface GameEntity : NSObject{
    
}
@property float radius;
@property float theta;
@property VBOs buffers;
@property GLuint texture;
@property int numVertices;
-(id)initRadius:(float)r theta:(float)t;
@end
