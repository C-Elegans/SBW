//
//  Entity.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Entity.h"

@implementation Entity
-(id)initPosition:(vec3)pos{
    self = [super init];
    position = pos;
    
    
    
    return self;
}
@end
