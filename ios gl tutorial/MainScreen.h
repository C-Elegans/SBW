//
//  Entity.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathHelper.h"
#import "LoaderHelper.h"
#import <GLKit/GLKit.h>

@interface MainScreen : NSObject{
    @public GLuint vaoID;
    @public GLuint texture;
    @public int numVertices;

    @protected
    vec3 position;
    
}
-(id)initPosition:(vec3)pos view:(UIView*)view;
-(BOOL)touchEnded:(CGPoint)point;
-(NSArray*)getButtons;
@end
