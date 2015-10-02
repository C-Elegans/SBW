//
//  TextChar.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "TextChar.h"
#import "LoaderHelper.h"
#define WIDTH 14
#define HEIGHT 8
#define V_CORRECTION 0.8359
#define H_CORRECTION 0.98242
const Vertex textVertices[] = {
	{{0, 0, 0}, {0,.9}},
	{{0, .1, 0}, {0,0.1}},
	{{.05, .1, 0}, {1,0.1}},
	{{.05, 0, 0}, {1,.9}}
};

const GLushort textIndices[] = {
	0, 1, 2,
	2, 3, 0
};
@interface TextChar(){
	NSString* textIndex;
}
@end
@implementation TextChar
@synthesize character = _character;
-(id)initWithChar:(char)character x:(float)x y:(float)y {
	self = [super init];
	_vaoID = [LoaderHelper loadToVBOS:&textVertices[0] verticesSize:sizeof(textVertices) indices:&textIndices[0] indicesSize:sizeof(textIndices) objectName:@"textChar"];
	_texture = [LoaderHelper loadTexture:@"lcd.png" enableMipmaps:YES];
	_numVertices = sizeof(textIndices)/sizeof(GLushort);
	textIndex = @"*~&_#=+%-$^\\@/|><}{][)(:;,.'?`!\"0987654321zyxwvutsrqponmlkjihgfedcba         ZYXWVUTSRQPONMLKJIHGFEDCBA";
	self.character = character;
	_position = (vec2){x,y};
	return self;
}
-(void)setCharacter:(char)character{
	@synchronized(self) {
		_character = character;
		NSRange range =[textIndex rangeOfString:[NSString stringWithFormat:@"%c", _character]];
		int index = (int)range.location;
		float xO, yO;
		xO = index % WIDTH;
		yO = index / WIDTH;
		_offset = (vec2){(xO/(float)WIDTH)*H_CORRECTION,(yO/(float)HEIGHT)*V_CORRECTION};
		//_offset = (vec2){2.0/14.0,0/8.5};
	}
}
-(char)character{
	@synchronized(self) {
		return _character;
	}
}
@end
