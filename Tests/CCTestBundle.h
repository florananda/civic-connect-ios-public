//
//  CCTestBundle.h
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/29.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CivicConnect/CivicConnect-Swift.h>

NS_SWIFT_NAME(TestBundle)
@interface CCTestBundle : NSObject<CCConnectBundle>

@property (nonatomic, readonly, copy) NSString *applicationIdentifier;
@property (nonatomic, readonly, copy) NSString *mobileApplicationIdentifier;
@property (nonatomic, readonly, copy) NSString *secret;
@property (nonatomic, readonly, copy) NSString *redirectScheme;
@property (nonatomic, readonly, copy) NSArray<NSString *> *urlSchemes;

- (nonnull instancetype)initWithApplicationIdentifier:(nullable NSString *)applicationIdentifier mobileApplicationIdentifier:(nullable NSString *)mobileApplicationIdentifier secret:(nullable NSString *)secret redirectScheme:(nullable NSString *)redirectScheme urlSchemes:(nullable NSArray<NSString *> *)urlSchemes;

@end
