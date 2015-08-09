//
//  LoaderHelperTests.m
//  Small Blue World
//
//  Created by Michael Nolan on 8/9/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OpenGLES/ES2/gl.h>
#import "LoaderHelper.h"
@interface LoaderHelperTests : XCTestCase

@end

@implementation LoaderHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadToTexture {
    GLuint texture = [LoaderHelper loadTexture:@"platform.png"];
    GLuint texture2=[LoaderHelper loadTexture:@"platform.png"];
    XCTAssert(texture == texture2);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


@end
