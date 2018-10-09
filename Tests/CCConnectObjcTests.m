//
//  CCConnectObjcTests.m
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/29.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CCTestBundle.h"
#import "CCMockConnectDelegate.h"
#import "CivicConnect_Tests-Swift.h"
#import <CivicConnect/CivicConnect-Swift.h>

@interface CCConnectObjcTests : XCTestCase
@property (nonatomic, strong) CCConnectHelper *helper;
@end

@implementation CCConnectObjcTests

- (void)setUp {
    [super setUp];
    self.helper = [CCConnectHelper new];
}

- (void)tearDown {
    self.helper = nil;
    [super tearDown];
}

- (void)testShouldInitializeConnectWithBundleThatReturnsNonNilApplicationIdentifierAndMobileApplicationIdentifierAndSecret {
    id<CCConnectBundle> bundle = [[CCTestBundle alloc] initWithApplicationIdentifier:@"applicationIdentifier"
                                                         mobileApplicationIdentifier:@"com.civic.connect.sample"
                                                                              secret:@"testSecret"
                                                                      redirectScheme:nil
                                                                          urlSchemes:nil];
    
    NSError *error;
    CCConnect *serviceUnderTest = [CCConnect initializeWithBundle:bundle error:&error];
    
    XCTAssertNil(error);
    XCTAssertNotNil(serviceUnderTest);
}

- (void)testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsNilApplicationIdentifier {
    id<CCConnectBundle> bundle = [[CCTestBundle alloc] initWithApplicationIdentifier:nil
                                                         mobileApplicationIdentifier:@"com.civic.connect.sample"
                                                                              secret:@"testSecret"
                                                                      redirectScheme:nil
                                                                          urlSchemes:nil];
    
    NSError *error;
    CCConnect *serviceUnderTest = [CCConnect initializeWithBundle:bundle error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(serviceUnderTest);
}

- (void)testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsNilMobileApplicationIdentifier {
    id<CCConnectBundle> bundle = [[CCTestBundle alloc] initWithApplicationIdentifier:@"applicationIdentifier"
                                                         mobileApplicationIdentifier:nil
                                                                              secret:@"testSecret"
                                                                      redirectScheme:nil
                                                                          urlSchemes:nil];
    
    NSError *error;
    CCConnect *serviceUnderTest = [CCConnect initializeWithBundle:bundle error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(serviceUnderTest);
}

- (void)testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsNilSecret {
    id<CCConnectBundle> bundle = [[CCTestBundle alloc] initWithApplicationIdentifier:@"applicationIdentifier"
                                                         mobileApplicationIdentifier:@"com.civic.connect.sample"
                                                                              secret:nil
                                                                      redirectScheme:nil
                                                                          urlSchemes:nil];
    
    NSError *error;
    CCConnect *serviceUnderTest = [CCConnect initializeWithBundle:bundle error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(serviceUnderTest);
}

- (void)testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsRedirectSchemeWithEmptyUrlSchemes {
    id<CCConnectBundle> bundle = [[CCTestBundle alloc] initWithApplicationIdentifier:@"applicationIdentifier"
                                                         mobileApplicationIdentifier:@"com.civic.connect.sample"
                                                                              secret:@"testSecret"
                                                                      redirectScheme:@"one"
                                                                          urlSchemes:@[]];
    
    NSError *error;
    CCConnect *serviceUnderTest = [CCConnect initializeWithBundle:bundle error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(serviceUnderTest);
}

- (void)testShouldThrowErrorWhenInitializingConnectWithBundleThatReturnsRedirectSchemeNotFoundInUrlSchemes {
    id<CCConnectBundle> bundle = [[CCTestBundle alloc] initWithApplicationIdentifier:@"applicationIdentifier"
                                                         mobileApplicationIdentifier:@"com.civic.connect.sample"
                                                                              secret:@"testSecret"
                                                                      redirectScheme:@"one"
                                                                          urlSchemes:@[@"two", @"three"]];
    
    NSError *error;
    CCConnect *serviceUnderTest = [CCConnect initializeWithBundle:bundle error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(serviceUnderTest);
}

- (void)testShouldInitializeConnectWithBundleThatReturnsNonNilApplicationIdentifierAndMobileApplicationIdentifierAndSecretAndRedirectSchemeContainedInUrlSchemes {
    id<CCConnectBundle> bundle = [[CCTestBundle alloc] initWithApplicationIdentifier:@"applicationIdentifier"
                                                         mobileApplicationIdentifier:@"com.civic.connect.sample"
                                                                              secret:@"testSecret"
                                                                      redirectScheme:@"one"
                                                                          urlSchemes:@[@"one", @"two", @"three"]];
    
    NSError *error;
    CCConnect *serviceUnderTest = [CCConnect initializeWithBundle:bundle error:&error];
    
    XCTAssertNil(error);
    XCTAssertNotNil(serviceUnderTest);
}

- (void)testShouldStartSession {
    CCMockConnectDelegate *mockDelegate = [CCMockConnectDelegate new];
    CCConnect *serviceUnderTest = self.helper.serviceUnderTest;
    
    [serviceUnderTest connectWithType:CCScopeRequestTypeBasicSignup delegate:mockDelegate];
    
    XCTAssertTrue(self.helper.didStartSession);
}

- (void)testShouldReturnYesWhenCheckingIfCanHandleUrl {
    CCMockConnectDelegate *mockDelegate = [CCMockConnectDelegate new];
    CCConnect *serviceUnderTest = self.helper.serviceUnderTest;
    [serviceUnderTest connectWithType:CCScopeRequestTypeBasicSignup delegate:mockDelegate];
    
    self.helper.sessionCanHandleUrl = YES;
    
    BOOL result = [serviceUnderTest canHandleUrl:[NSURL URLWithString:@"http://google.com"]];
    
    XCTAssertTrue(result);
}

- (void)testShouldReturnNoWhenCheckingIfCanHandleUrl {
    CCMockConnectDelegate *mockDelegate = [CCMockConnectDelegate new];
    CCConnect *serviceUnderTest = self.helper.serviceUnderTest;
    [serviceUnderTest connectWithType:CCScopeRequestTypeBasicSignup delegate:mockDelegate];
    
    self.helper.sessionCanHandleUrl = NO;
    
    BOOL result = [serviceUnderTest canHandleUrl:[NSURL URLWithString:@"http://google.com"]];
    
    XCTAssertFalse(result);
}

- (void)testShouldReturnYesWhenHandlingValidUrl {
    CCMockConnectDelegate *mockDelegate = [CCMockConnectDelegate new];
    CCConnect *serviceUnderTest = self.helper.serviceUnderTest;
    [serviceUnderTest connectWithType:CCScopeRequestTypeBasicSignup delegate:mockDelegate];
    
    self.helper.sessionHandleUrl = YES;
    
    BOOL result = [serviceUnderTest handleUrl:[NSURL URLWithString:@"http://google.com"]];
    
    XCTAssertTrue(result);
}

- (void)testShouldReturnNoWhenHandlingInvalidUrl {
    CCMockConnectDelegate *mockDelegate = [CCMockConnectDelegate new];
    CCConnect *serviceUnderTest = self.helper.serviceUnderTest;
    [serviceUnderTest connectWithType:CCScopeRequestTypeBasicSignup delegate:mockDelegate];
    
    self.helper.sessionHandleUrl = NO;
    
    BOOL result = [serviceUnderTest handleUrl:[NSURL URLWithString:@"http://google.com"]];
    
    XCTAssertFalse(result);
}

- (void)testShouldStartPollingForUserDataWhenPollingForUserData {
    CCMockConnectDelegate *mockDelegate = [CCMockConnectDelegate new];
    CCConnect *serviceUnderTest = self.helper.serviceUnderTest;
    [serviceUnderTest connectWithType:CCScopeRequestTypeBasicSignup delegate:mockDelegate];
    
    [serviceUnderTest startPollingForUserData];
    
    XCTAssertTrue(self.helper.didStartPollingForUserData);
}

- (void)testShouldStopPollingForUserDataWhenStoppingPollingForUserData {
    CCMockConnectDelegate *mockDelegate = [CCMockConnectDelegate new];
    CCConnect *serviceUnderTest = self.helper.serviceUnderTest;
    [serviceUnderTest connectWithType:CCScopeRequestTypeBasicSignup delegate:mockDelegate];
    
    [serviceUnderTest stopPollingForUserData];
    
    XCTAssertTrue(self.helper.didStopPollingForUserData);
}

@end
