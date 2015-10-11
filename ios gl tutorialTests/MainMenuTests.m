//
//  MainMenuTests.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MainScreen.h"
@interface MainMenuTests : XCTestCase{
    MainScreen* mainScreen;
}

@end

@implementation MainMenuTests

- (void)setUp {
    [super setUp];
	//mainScreen = [[MainScreen alloc]initPosition:(vec3){0.0f,0.0f,0.0f}];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    /*XCTAssert([mainScreen touchEnded:CGPointMake(0.2f, 0.4f)] == YES);
    XCTAssert([mainScreen touchEnded:CGPointMake(0.8f, 0.4f)] == YES);
    XCTAssert([mainScreen touchEnded:CGPointMake(0.1f, 0.1f)] == NO);
    XCTAssert([mainScreen touchEnded:CGPointMake(0.9f, 0.9f)] == NO);*/
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
