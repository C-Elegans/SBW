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
    CGRect rect1 = CGRectMake(1, TWO_PI-0.5, 0.25, 1);
    CGRect rect2 = CGRectMake(1.01, 0, 0.3, 0.1);
    
    XCTAssert([MathHelper rect:rect1 intersects:rect2]==YES);
    
}
-(void)testMoveVector{
    CGRect rect1 = CGRectMake(0.2, 0.3, 0.3, 0.5);
    CGRect rect2 = CGRectMake(0.4, 0, 0.3, 0.5);
    vec2 moveVec = [MathHelper moveToUndoCollision:rect1 withRect:rect2];
    NSLog(@"MoveVector for collision is: %fx, %fy",moveVec.x,moveVec.y);
    XCTAssert(-0.09>moveVec.x && moveVec.x > -0.11);
    rect1 = CGRectMake(1, TWO_PI-0.5, 0.25, 1);
    rect2 = CGRectMake(1.01, 0, 0.3, 0.1);
    moveVec = [MathHelper moveToUndoCollision:rect1 withRect:rect2];
    XCTAssert(0<moveVec.x<0.1);
    XCTAssert(moveVec.y == 0);
    //XCTAssert(0.19<moveVec.y && moveVec.y < 0.21);
}
- (void)testPerformanceExample {
    
    [self measureBlock:^{
        

    }];
}

@end
