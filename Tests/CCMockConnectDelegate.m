//
//  CCMockConnectDelegate.m
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "CCMockConnectDelegate.h"

@implementation CCMockConnectDelegate

- (void)connectDidFailWithError:(ConnectError *)error {
    self.lastError = error;
}

- (void)connectDidFinishWithUserData:(CCUserData *)userData {
    self.lastUserData = userData;
}

- (void)connectDidChangeStatus:(enum CCConnectStatus)newStatus {
    self.lastStatus = newStatus;
}

@end
