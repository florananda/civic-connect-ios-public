//
//  CCTestBundle.m
//  CivicConnect_Tests
//
//  Created by Justin Guedes on 2018/08/29.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "CCTestBundle.h"

@interface CCTestBundle ()
@property (nonatomic, readwrite, copy) NSString *applicationIdentifier;
@property (nonatomic, readwrite, copy) NSString *mobileApplicationIdentifier;
@property (nonatomic, readwrite, copy) NSString *secret;
@property (nonatomic, readwrite, copy) NSString *redirectScheme;
@property (nonatomic, readwrite, copy) NSArray<NSString *> *urlSchemes;
@property (nonatomic, readwrite) BOOL devMode;
@end

@implementation CCTestBundle

- (instancetype)initWithApplicationIdentifier:(NSString *)applicationIdentifier mobileApplicationIdentifier:(NSString *)mobileApplicationIdentifier secret:(NSString *)secret redirectScheme:(NSString *)redirectScheme urlSchemes:(NSArray<NSString *> *)urlSchemes {
    self = [super init];
    if (self) {
        self.applicationIdentifier = applicationIdentifier;
        self.mobileApplicationIdentifier = mobileApplicationIdentifier;
        self.secret = secret;
        self.redirectScheme = redirectScheme;
        self.urlSchemes = urlSchemes;
        self.devMode = NO;
    }

    return self;
}

- (instancetype)initWithApplicationIdentifier:(NSString *)applicationIdentifier mobileApplicationIdentifier:(NSString *)mobileApplicationIdentifier secret:(NSString *)secret redirectScheme:(NSString *)redirectScheme urlSchemes:(NSArray<NSString *> *)urlSchemes devMode:(BOOL)devMode {
    self = [super init];
    if (self) {
        self.applicationIdentifier = applicationIdentifier;
        self.mobileApplicationIdentifier = mobileApplicationIdentifier;
        self.secret = secret;
        self.redirectScheme = redirectScheme;
        self.urlSchemes = urlSchemes;
        self.devMode = devMode;
    }
    
    return self;
}

@end
