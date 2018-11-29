//
//  CCMockConnectDelegate.h
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CivicConnect/CivicConnect-Swift.h>

@interface CCMockConnectDelegate : NSObject<CCConnectDelegate>

@property (nonatomic, strong) ConnectError *lastError;

@property (nonatomic, strong) CCUserData *lastUserData;

@property (nonatomic) enum CCConnectStatus lastStatus;

@property (nonatomic, strong) NSString *lastToken;

@property (nonatomic) BOOL shouldFetchUserData;

@end
