//
//  AIHelper.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/9/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathHelper.h"
@interface AIHelper : NSObject
+(vec2)calculateShortestMoveVectorFrom:(vec2)initial to:(vec2)final;
@end
