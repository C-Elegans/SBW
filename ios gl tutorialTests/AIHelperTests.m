//
//  AIHelperTests.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/9/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AIHelper.h"
#define EPSILON 0.0001
@interface AIHelperTests : XCTestCase

@end

@implementation AIHelperTests
BOOL floatEqualsFloat(float one, float two){
	return (two - EPSILON < one) && (one < two + EPSILON);
}
BOOL floatEqualsFloatEpsilon(float one, float two, float epsilon){
	return (two - epsilon < one) && (one < two + epsilon);
}
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testMoveVector{
	vec2 obj1 = {3,0.5};
	vec2 obj2 = {5,6};
	vec2 result = [AIHelper calculateShortestMoveVectorFrom:obj1 to:obj2];
	XCTAssert(floatEqualsFloat(result.x, 2));
	XCTAssert(floatEqualsFloatEpsilon(result.y, -0.7831, 0.1));
	obj2 = (vec2){ 2,1};
	result = [AIHelper calculateShortestMoveVectorFrom:obj1 to:obj2];
	XCTAssert(floatEqualsFloat(result.x, -1));
	XCTAssert(floatEqualsFloat(result.y, 0.5));
}

@end
