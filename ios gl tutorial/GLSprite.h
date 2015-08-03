//
//  GLSprite.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
@interface GLSprite : NSObject
-(id)initWithFile:(NSString *)fileName effect:(GLKBaseEffect *)effect;
-(void)render;
@end
