//
//  AIHelper.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/9/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "AIHelper.h"

@implementation AIHelper
+(vec2)calculateShortestMoveVectorFrom:(vec2)initial to:(vec2)final{
	float r = final.x -initial.x;
	float t, t1,t2;
	t1 = final.y - initial.y;
	t2 = (final.y - TWO_PI) - initial.y;
	t = t1;
	if(t2<t1)t=t2;
	return (vec2){r,t};
}
@end
