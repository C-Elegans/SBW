//
//  MathHelperTests.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MathHelper.h"
@interface MathHelperTests : XCTestCase

@end

@implementation MathHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDot{
    vec3 vector1 = {1.0f, 1.5f,2.0f};
    vec3 vector2 = {5.0f, 3.2f,0.5f};
    XCTAssert([MathHelper vec3Dot:vector1 vector2:vector2] ==10.8f);
}
-(void)testBoxIntersection{
    CGRect rect1 = CGRectMake(1, 0.25, 0.25, 0.5);
    CGRect rect2 = CGRectMake(1.1, 0.1, 0.3, 0.2);
    CGRect rect3 = CGRectMake(1, 1, 0.3, 0.3);
    XCTAssert([MathHelper rect:rect1 intersects:rect2]==YES);
    XCTAssert([MathHelper rect:rect1 intersects:rect3]==NO);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
