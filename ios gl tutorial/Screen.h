//
//  Screen.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MathHelper.h"
#import "Button.h"
@interface Screen : NSObject{
@public GLuint vaoID;
@public GLuint texture;
@public int numVertices;

@protected vec3 position;
}
-(nonnull id)initPosition:(vec3)pos view:(nonnull UIView*)view;
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

-(nullable NSArray<Button*>*)getAllButtons;
-(nullable NSArray*)getText;
-(void)update;
@end