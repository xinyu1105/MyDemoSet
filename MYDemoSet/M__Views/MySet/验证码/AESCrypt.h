//
//  AESCrypt.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/4/15.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESCrypt : NSObject

//通用加密方法
+ (NSString *)encryptString:(NSString *)content key:(NSString *)key;
//通用解密方法
+ (NSString *)decryptString:(NSString *)content key:(NSString *)key;


+(NSString *)AES128Encrypt1:(NSString *)content key16:(NSString *)key;
+(NSString *)AES128Decrypt1:(NSString *)content key16:(NSString *)key;

+(NSString *)AES128Encrypt1:(NSString *)content key32:(NSString *)key;
+(NSString *)AES128Decrypt1:(NSString *)content key32:(NSString *)key;



@end

NS_ASSUME_NONNULL_END
