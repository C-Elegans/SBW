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
@synthesize string=_string;
-(id)initWithString:(NSString*)string x:(float)x y:(float)y color:(vec4)color size:(float)size{
	self = [super init];
	textChars = [NSMutableArray new];
	
	_position = (vec2){x,y};
	shader = [TextShader new];
	_color = color;
	_size=size;
	self.string = string;
	return self;
}
-(id)initWithStringCentered:(NSString*)string x:(float)x y:(float)y color:(vec4)color size:(float)size{
	self = [super init];
	_color = color;
	_size=size;
	textChars = [NSMutableArray new];
	x = x-((0.04*_size*([string length]-1))/2);
	y-=0.025*size;
	_position = (vec2){x,y};
	shader = [TextShader new];
	
	self.string = string;
	return self;
}
-(NSArray<TextChar*>*)getChars{
	return textChars;
}
-(NSString*)string{
	@synchronized(self) {
		return _string;
	}
}
-(void)setString:(NSString *)string{
	@synchronized(self) {
		_string = string;
		float xpos = _position.x;
		[textChars removeAllObjects];
		for(int i=0;i<[string length];i++){
			
			char c = [string characterAtIndex:i];
			[textChars addObject:[[TextChar alloc]initWithChar:c x:xpos y:_position.y]];
			xpos+= 0.04*_size;
		}
	}
}

@end
