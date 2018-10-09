//
//  CCConnectSecurity.h
//  CivicConnect
//
//  Created by Justin Guedes on 2018/09/10.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(ConnectSecurity)
@interface CCConnectSecurity : NSObject

+ (nullable NSData *)decryptHexString:(nonnull NSString *)hexString usingSecret:(nonnull NSString *)secret iv:(nonnull NSString *)iv;
+ (BOOL)verifyHexString:(nonnull NSString *)hexString usingPublicKey:(nonnull NSString *)publicKey signature:(nonnull NSString *)signature;

@end
