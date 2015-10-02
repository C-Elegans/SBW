//
//  TextRenderer.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TextBox.h"
@interface TextRenderer : NSObject
-(id)init;
-(void)render:(NSArray<TextBox*>*)boxes view:(UIView*)view;
@end
