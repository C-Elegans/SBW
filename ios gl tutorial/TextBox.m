//
//  TextBox.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "TextBox.h"
#import "TextChar.h"
#import "TextShader.h"
@interface TextBox(){
	NSMutableArray<TextChar*>* textChars;
	TextShader* shader;
}
@end
@implementation TextBox
-(id)initWithString:(NSString*)string x:(float)x y:(float)y{
	self = [super init];
	textChars = [NSMutableArray new];
	_string = string;
	_position = (vec2){x,y};
	shader = [TextShader new];
	float xpos = _position.x;
	for(int i=0;i<[string length];i++){
		
		char c = [string characterAtIndex:i];
		[textChars addObject:[[TextChar alloc]initWithChar:c x:xpos y:_position.y]];
		xpos+= 0.05;
	}
	return self;
}
-(NSArray<TextChar*>*)getChars{
	return textChars;
}
@end
