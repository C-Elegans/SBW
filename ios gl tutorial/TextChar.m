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
const Vertex textVertices[] = {
	{{0, 0, 0}, {0,1}},
	{{0, .1, 0}, {1,1}},
	{{.1, .1, 0}, {1,0}},
	{{.1, 0, 0}, {0,0}}
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
		//_offset = (vec2){(float)(index % WIDTH)/14.0,1-((float)(index/WIDTH)/8.0)};
			_offset = (vec2){1/14,1/8};
	}
}
-(char)character{
	@synchronized(self) {
		return _character;
	}
}
@end
