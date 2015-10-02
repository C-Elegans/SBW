//
//  TextBox.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathHelper.h"
#import "TextChar.h"
@interface TextBox : NSObject
@property vec2 position;
@property NSString* string;
-(id)initWithString:(NSString*)string x:(float)x y:(float)y;
-(NSArray<TextChar*>*)getChars;
@end
