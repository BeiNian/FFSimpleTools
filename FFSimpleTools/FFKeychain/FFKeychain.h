//
//  FFKeychain.h
//  Structure
//
//  Created by cts on 2018/1/12.
//  Copyright © 2018年 cts. All rights reserved.
//
/*
 kSecClass:有五个值，分别为
 kSecClassGenericPassword(通用密码－－也是接下来使用的)、
 kSecClassInternetPassword(互联网密码)、
 kSecClassCertificate(证书)、
 kSecClassKey(密钥)、
 kSecClassIdentity(身份)
 
 kSecAttrService:服务
 kSecAttrServer:服务器域名或IP地址
 kSecAttrAccount:账号
 kSecAttrAccessGroup: 可以在应用之间共享keychain中的数据
 kSecMatchLimit:返回搜索结果，kSecMatchLimitOne（一个）、kSecMatchLimitAll（全部）
 
 */

#import <Foundation/Foundation.h>
///IDFV Save the value of the key
#define IDENTIFIERKEY @"identifierForVendor"

@interface FFKeychain : NSObject

/**
 存储数据到钥匙串中
 
 @param key String
 @param value value
 @return return value description
 */
+ (BOOL)storeIdentifierForVendorKey:(NSString *)key Value:(NSString *)value;

/**
 查找数据
 
 @param key key
 @return return value description
 */
+ (BOOL)findIdentifierForVendorKey:(NSString *)key;

/**
 获取数据

 @param key key
 @return return String
 */
+ (NSString *)acquireIdentifierForVendorKey:(NSString *)key;

/**
 更新钥匙串
 
 @param key String
 @param value new value
 @return return value description
 */
+ (BOOL)updateIdentifierForVendorKey:(NSString *)key Value:(NSString *)value;

/**
 删除钥匙串
 
 @param key String
 @return return value description
 */
+ (BOOL)deleteIdentifierForVendorKey:(NSString *)key;

/**
 打印属性信息
 
 @param key key
 */
+ (void)printAttrWithKey:(NSString *)key;

+ (NSString *)acquireOnlyIdentifier;

@end
