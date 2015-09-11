//
//  Entity.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MainScreen.h"
#import "MainScreenPlayButton.h"
#import "OpenGLViewController.h"
@interface MainScreen(){
	MainScreenPlayButton* playButton;
}
@end
const Vertex Vertices[] = {
    {{1, -1, 0}, {1,1}},
    {{1, 1, 0}, {1,0}},
    {{-1, 1, 0}, {0,0}},
    {{-1, -1, 0}, {0,1}}
};

const GLushort Indices[] = {
    0, 1, 2,
    2, 3, 0
};
const Rectangle PlayButton = {0.1434f,0.3706f ,0.7117f,0.1652f};
@implementation MainScreen
-(id)initPosition:(vec3)pos view:(UIView*) view{
    self = [super init];
	playButton = [[MainScreenPlayButton alloc]initWithPositionX:-0.72 y:0 view:view];
    position = pos;
    vaoID = [LoaderHelper loadToVBOS:&Vertices[0] verticesSize:sizeof(Vertices) indices:&Indices[0] indicesSize:sizeof(Indices) objectName:@"MainScreen"];
    numVertices = sizeof(Indices)/sizeof(Indices[0]);
    texture = [LoaderHelper loadTexture:@"mainScreen.png"];
    return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	[playButton touchesEnded:touches withEvent:event];
}
-(NSArray*)getButtons{
	NSArray* array = [[NSArray alloc] initWithObjects:playButton, nil];
	return array;
}
@end
