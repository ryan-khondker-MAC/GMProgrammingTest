//
//  WeatherAppTestTests.m
//  WeatherAppTestTests
//
//  Created by Ryan on 4/12/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WeatherAppTestTests : XCTestCase

@property NSURLSession *sessionUnderTest;
@property NSString *urlAsString;
@property NSURL *url;

@end

@implementation WeatherAppTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _sessionUnderTest = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    _urlAsString = @"https://api.wunderground.com/api/b058bb83eb8b1cef/forecast/geolookup/conditions/q/GA/Atlanta.json";
    _url = [NSURL URLWithString:_urlAsString];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _sessionUnderTest = nil;
    _urlAsString = nil;
    _url = nil;
    [super tearDown];
}

- (void)testValidCallToApiReturnsStatusCode200 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *promise = [self expectationWithDescription: @"Status Code 200"];
    [[_sessionUnderTest dataTaskWithURL:_url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            XCTFail(@"Error: %@", [error localizedDescription]);
            return;
        }
        else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if ([httpResponse statusCode] == 200) {
                    [promise fulfill];
                }
                else {
                    XCTFail(@"Status Code %ld", [httpResponse statusCode]);
                    return;
                }
            }
            else {
                XCTFail(@"Not an HTTP response");
                return;
            }
        }
    }] resume];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
