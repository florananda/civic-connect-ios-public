//
//  CCConnectSecurity.m
//  CivicConnect
//
//  Created by Justin Guedes on 2018/09/10.
//

#import "CCConnectSecurity.h"
#import <CommonCrypto/CommonCrypto.h>

static NSString const *rsaTag = @"com.civic.connect.rsa.tag";

@implementation CCConnectSecurity

+ (NSData *)decryptHexString:(NSString *)hexString usingSecret:(NSString *)secret iv:(NSString *)iv {
    NSData *dataToDecrypt = [self dataFromHexString:hexString];
    return [self decryptData:dataToDecrypt usingSecret:secret iv:iv];
}

+ (BOOL)verifyHexString:(NSString *)hexString usingPublicKey:(NSString *)publicKey signature:(NSString *)signature {
    NSData *data = [hexString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *sha256Data = [self sha256HashFromData:data];
    NSData *publicKeyData = [self stripPublicKey:publicKey];
    NSData *signatureData = [self dataFromHexString:signature];
    return [self verifyData:sha256Data usingPublicKey:publicKeyData signature:signatureData];
}

#pragma mark - Private Implementation

+ (NSData *)decryptData:(NSData *)dataToDecrypt usingSecret:(NSString *)secret iv:(NSString *)iv {
    char secretPtr[kCCKeySizeAES256 + 1];
    bzero(secretPtr, sizeof(secretPtr));
    [secret getCString:secretPtr maxLength:sizeof(secretPtr) encoding:NSUTF8StringEncoding];
    
    NSData *ivData = [self dataFromHexString:iv];
    const void *ivPtr = ivData.bytes;
    
    const void *dataToDecryptBytes = [dataToDecrypt bytes];
    NSUInteger dataLength = [dataToDecrypt length];
    size_t bufferSize = dataLength + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorRef cryptor;
    CCCryptorStatus cryptorStatus;
    cryptorStatus = CCCryptorCreateWithMode(kCCDecrypt,
                                          kCCModeCTR,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          ivPtr,
                                          secretPtr,
                                          kCCKeySizeAES256,
                                          nil,
                                          0,
                                          0,
                                          kCCModeOptionCTR_BE,
                                          &cryptor);
    
    if (cryptorStatus != kCCSuccess) {
        return nil;
    }
    
    cryptorStatus = CCCryptorUpdate(cryptor,
                                  dataToDecryptBytes,
                                  dataLength,
                                  buffer,
                                  bufferSize,
                                  &numBytesEncrypted);
    
    if (cryptorStatus != kCCSuccess) {
        CCCryptorRelease(cryptor);
        return nil;
    }
    
    NSMutableData *cipherData = [NSMutableData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    
    cryptorStatus = CCCryptorFinal(cryptor,
                                 cipherData.mutableBytes,
                                 cipherData.length,
                                 &numBytesEncrypted);
    
    CCCryptorRelease(cryptor);
    
    if (cryptorStatus == kCCSuccess) {
        return cipherData;
    }
    
    free(buffer);
    return nil;
}

+ (BOOL)verifyData:(NSData *)data usingPublicKey:(NSData *)publicKey signature:(NSData *)signature {
    SecKeyRef publicKeyRef;
    if (@available(iOS 10, *)) {
        publicKeyRef = [self createPublicKeyWithData:publicKey];
    } else {
        NSData *tagData = [rsaTag dataUsingEncoding:NSUTF8StringEncoding];
        publicKeyRef = [self createPublicKeyWithData:publicKey tagData:tagData];
    }
    
    if (publicKeyRef == nil) {
        return NO;
    }

    OSStatus verifyStatus;
    verifyStatus = SecKeyRawVerify(publicKeyRef,
                                   kSecPaddingPKCS1SHA256,
                                   data.bytes,
                                   data.length,
                                   signature.bytes,
                                   signature.length);

    CFRelease(publicKeyRef);
    
    return verifyStatus == errSecSuccess;
}

+ (NSData *)dataFromHexString:(NSString *)hexString {
    const char *chars = [hexString UTF8String];
    NSUInteger i = 0, len = hexString.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}

+ (NSData *)sha256HashFromData:(NSData *)inData {
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256_CTX ctx;
    
    CC_SHA256_Init(&ctx);
    CC_SHA256_Update(&ctx, [inData bytes], (CC_LONG)[inData length]);
    CC_SHA256_Final(digest, &ctx);
    
    return [[NSData alloc] initWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
}

+ (NSData *)stripPublicKey:(NSString *)publicKey {
    NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return ![evaluatedObject hasPrefix:@"-----BEGIN"] && ![evaluatedObject hasPrefix:@"-----END"];
    }];
    NSArray *lines = [[publicKey componentsSeparatedByString:@"\n"] filteredArrayUsingPredicate:pred];
    NSString *strippedPublicKey = [lines componentsJoinedByString:@""];
    NSData *strippedPublicKeyData = [[NSData alloc] initWithBase64EncodedString:strippedPublicKey options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return strippedPublicKeyData;
}

+ (SecKeyRef)createPublicKeyWithData:(NSData *)data NS_AVAILABLE_IOS(10) {
    NSUInteger dataSizeInBits = data.length * 8;
    NSDictionary *keyDict = @{
                              (__bridge id)kSecAttrType: (__bridge id)kSecAttrKeyTypeRSA,
                              (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPublic,
                              (__bridge id)kSecAttrKeySizeInBits: [NSNumber numberWithUnsignedInteger:dataSizeInBits],
                              (__bridge id)kSecReturnPersistentRef: [NSNumber numberWithBool:YES]
                              };
    
    CFErrorRef error;
    SecKeyRef publicKeyRef = SecKeyCreateWithData((__bridge CFDataRef) data, (__bridge CFDictionaryRef) keyDict, &error);
    return publicKeyRef;
}

+ (SecKeyRef)createPublicKeyWithData:(NSData *)data tagData:(NSData *)tagData {
    NSDictionary *keyDeleteDict = @{
                                    (__bridge id)kSecClass: (__bridge id)kSecClassKey,
                                    (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
                                    (__bridge id)kSecAttrApplicationTag: tagData
                                    };
    
    SecItemDelete((__bridge CFDictionaryRef) keyDeleteDict);
    
    NSDictionary *keyAddDict = @{
                              (__bridge id)kSecClass: (__bridge id)kSecClassKey,
                              (__bridge id)kSecAttrApplicationTag: tagData,
                              (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
                              (__bridge id)kSecValueData: data,
                              (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPublic,
                              (__bridge id)kSecReturnPersistentRef: [NSNumber numberWithBool:YES],
                              (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleWhenUnlocked,
                              };
    
    OSStatus addStatus;
    SecKeyRef addKeyRef;
    addStatus = SecItemAdd((__bridge CFDictionaryRef) keyAddDict, (CFTypeRef *)&addKeyRef);
    if (addKeyRef == nil || (addStatus != errSecSuccess && addStatus != errSecDuplicateItem)) {
        return nil;
    }
    
    NSDictionary *keyCopyDict = @{
                                  (__bridge id)kSecClass: (__bridge id)kSecClassKey,
                                  (__bridge id)kSecAttrApplicationTag: tagData,
                                  (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
                                  (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPublic,
                                  (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleWhenUnlocked,
                                  (__bridge id)kSecReturnRef: [NSNumber numberWithBool:YES]
                                  };
    
    OSStatus copyStatus;
    SecKeyRef copyKeyRef;
    copyStatus = SecItemCopyMatching((__bridge CFDictionaryRef) keyCopyDict, (CFTypeRef *)&copyKeyRef);
    if (copyKeyRef == nil || (addStatus != errSecSuccess && addStatus != errSecDuplicateItem)) {
        return nil;
    }
    
    return copyKeyRef;
}

@end
