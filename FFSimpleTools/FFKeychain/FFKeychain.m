//
//  FFKeychain.m
//  Structure
//
//  Created by cts on 2018/1/12.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "FFKeychain.h"
#import <UIKit/UIKit.h>
#import <Security/Security.h>

@implementation FFKeychain

+ (BOOL)storeIdentifierForVendorKey:(NSString *)key Value:(NSString *)value
{
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *dict = @{
                           (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                           (__bridge id)kSecAttrService:service,
                           (__bridge id)kSecAttrAccount:key,
                           (__bridge id)kSecValueData:valueData
                           };
    CFTypeRef typeResult = NULL;
    OSStatus state =  SecItemAdd((__bridge CFDictionaryRef)dict, &typeResult);
    if (state == errSecSuccess) {
        NSLog(@"store secceed");
        
        return YES;
    } else if (state == errSecDuplicateItem) {
        NSLog(@"钥匙串已经存在");
        return YES;
    }
    return NO;
}

+ (BOOL)findIdentifierForVendorKey:(NSString *)key
{
   NSString *value = [self acquireIdentifierForVendorKey:key];
    if (value) {
        return YES;
    }
    return NO;
}

+ (NSString *)acquireIdentifierForVendorKey:(NSString *)key {
    
    NSString *server = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *queueDict = @{
                                (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecAttrService:server,
                                (__bridge id)kSecAttrAccount:key,
                                (__bridge id)kSecReturnData:(__bridge id)kCFBooleanTrue
                                };
    // findData
    CFDataRef dataRef = NULL;
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)queueDict, (CFTypeRef*)&dataRef);
    if (state == errSecSuccess) {
        NSString *value = [[NSString alloc] initWithData:(__bridge_transfer NSData*)dataRef encoding:NSUTF8StringEncoding];
        
        return value;
    }
    return nil;
    

}

+ (BOOL)updateIdentifierForVendorKey:(NSString *)key Value:(NSString *)value
{
    NSString *server = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *queue = @{
                            (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService:server,
                            (__bridge id)kSecAttrAccount:key
                            };
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)queue, NULL);
    //存在修改
    if (state == errSecSuccess) {
        NSData *newData = [value dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *paramDict = @{
                                    (__bridge id)kSecValueData:newData
                                    };
        OSStatus updateState = SecItemUpdate((__bridge CFDictionaryRef)queue, (__bridge CFDictionaryRef)paramDict);
        if (updateState == errSecSuccess) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)deleteIdentifierForVendorKey:(NSString *)key
{
    NSString *server = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *queue = @{
                            (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService:server,
                            (__bridge id)kSecAttrAccount:key
                            };
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)queue, NULL);
    //存在
    if (state == errSecSuccess) {
        OSStatus deleteState = SecItemDelete((__bridge CFDictionaryRef)queue);
        if (deleteState == errSecSuccess) {
            return YES;
        }
    }
    return NO;
}

+ (void)printAttrWithKey:(NSString *)key
{
    NSString *server = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *queueDict = @{
                                (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecAttrService:server,
                                (__bridge id)kSecAttrAccount:key,
                                (__bridge id)kSecReturnData:(__bridge id)kCFBooleanTrue
                                };
    /// findAttr
    CFDictionaryRef resultDict = NULL;
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)queueDict, (CFTypeRef*)&resultDict);
    NSDictionary *result = (__bridge_transfer NSDictionary*)resultDict;
    if (state == errSecSuccess)
    {
        NSLog(@"server:%@",result[(__bridge id)kSecAttrService]);
        NSLog(@"account:%@",result[(__bridge id)kSecAttrAccount]);
        NSLog(@"assessGroup:%@",result[(__bridge id)kSecAttrAccessGroup]);
        NSLog(@"createDate:%@",result[(__bridge id)kSecAttrCreationDate]);
        NSLog(@"modifyDate:%@",result[(__bridge id)kSecAttrModificationDate]);
    }
    
}

#pragma mark -
+ (NSString *)acquireOnlyIdentifier {
    
    NSString *onlyIdentifier = nil;
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if (![FFKeychain findIdentifierForVendorKey:IDENTIFIERKEY]) {
        BOOL isStore = [FFKeychain storeIdentifierForVendorKey:IDENTIFIERKEY Value:identifierStr];
        if (isStore) {
            NSLog(@"onlyIdentifier 保存成功");
            onlyIdentifier = [FFKeychain acquireIdentifierForVendorKey:IDENTIFIERKEY];
        } else {
            onlyIdentifier = identifierStr;
            NSLog(@"onlyIdentifier 保存失败使用获取到的值");
        }
    } else {
        NSLog(@"onlyIdentifier 已存在");
        onlyIdentifier = [FFKeychain acquireIdentifierForVendorKey:IDENTIFIERKEY];
    }
    NSLog(@"onlyIdentifier = %@",onlyIdentifier);
    
    return onlyIdentifier;
}

@end
