//
//  AESCrypt.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/4/15.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import "AESCrypt.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



static char encodingTable[64] = {
'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };

@implementation AESCrypt
//通用加密方法
+ (NSString *)encryptString:(NSString *)content key:(NSString *)key{
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    // You can use md5 to make sure key is 16 bits long
    NSData *encryptData = [self doCipher:contentData context:kCCEncrypt key:key];
    // 对加密后的数据进行base64编码
    NSString *base64Str = [encryptData base64EncodedStringWithOptions:0];
    
    return base64Str;
}


//通用解密方法
+ (NSString *)decryptString:(NSString *)content key:(NSString *)key{
    
    NSData *base64Data = [[NSData alloc]initWithBase64EncodedString:content options:0];
    NSData *decryptData = [self doCipher:base64Data context:kCCDecrypt key:key];
    NSString *decryptStr = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    return  decryptStr;
    
}


+  (NSData *)doCipher:(NSData *)contentData context:(CCOperation)encryptOrDecrypt key:(NSString *)key{
   
    NSData *aSymmetricKey = [key dataUsingEncoding:NSUTF8StringEncoding];

    CCCryptorStatus ccStatus   = kCCSuccess;
    size_t          cryptBytes = 0;    // Number of bytes moved to buffer.
    NSMutableData  *dataOut    = [NSMutableData dataWithLength:contentData.length + key.length];
    ccStatus = CCCrypt( encryptOrDecrypt,
                       kCCAlgorithmAES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       (const void *)[aSymmetricKey bytes],
                       key.length,
                       NULL,
                       contentData.bytes,
                       contentData.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus != kCCSuccess) {
        
        NSLog(@"CCCrypt status: %d", ccStatus);
    }
 
    dataOut.length = cryptBytes;
    
    return dataOut;
}

+  (NSData *)AdoCipher:(NSData *)plainText context:(CCOperation)encryptOrDecrypt key:(NSString *)key{
   
    NSData *aSymmetricKey = [key dataUsingEncoding:NSUTF8StringEncoding];

    CCCryptorStatus ccStatus   = kCCSuccess;
    size_t          cryptBytes = 0;    // Number of bytes moved to buffer.
    NSMutableData  *dataOut    = [NSMutableData dataWithLength:plainText.length + kCCBlockSizeAES128]; // kCCBlockSizeAES128
    ccStatus = CCCrypt( encryptOrDecrypt,
                       kCCAlgorithmAES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       (const void *)[aSymmetricKey bytes],
                       kCCKeySizeAES256,// kCCBlockSizeAES128
                       NULL,
                       plainText.bytes,
                       plainText.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus != kCCSuccess) {
        
        NSLog(@"CCCrypt status: %d", ccStatus);
    }
 
    dataOut.length = cryptBytes;
    
    return dataOut;
}



+(NSString *)AES128Encrypt1:(NSString *)content key16:(NSString *)key{
   
    //为结束符'\0' +1
    char keyPtr[[key length]+1];//kCCKeySizeAES128,kCCKeySizeAES256
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    //1，string转Data
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [contentData length];
    //密文长度 <= 明文程度 + BlockSize
    size_t bufferSize = dataLength + kCCBlockSizeAES128;//key：16位
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,//keyData.bytes Y|keyPtr N
                                          kCCBlockSizeAES128,//keyData.length Y|key：16位（kCCBlockSizeAES128）
                                          NULL,
                                          contentData.bytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *dataOut = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //2，系统方法 Base64编码
        NSString *encryptStr = [dataOut base64EncodedStringWithOptions:0];
        return encryptStr;
    }
    free(buffer);
    return nil;
}

+(NSString *)AES128Decrypt1:(NSString *)content key16:(NSString *)key{
   
    //为结束符'\0' +1
    char keyPtr[[key length]+1];//kCCKeySizeAES128,kCCKeySizeAES256
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    //1，string转Data Base64解码
    NSData *contentData = [[NSData alloc]initWithBase64EncodedString:content options:0];
    NSUInteger contentDataLength = [contentData length];
    //密文长度 <= 明文程度 + BlockSize
    size_t bufferSize = contentDataLength + kCCBlockSizeAES128;//key：16位
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,//ECB
                                          keyPtr,//key
                                          kCCBlockSizeAES128,//key.length=16（kCCBlockSizeAES128）
                                          NULL,//ECB时iv为空
                                          contentData.bytes,
                                          contentDataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *dataOut = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        //2，data encode
        NSString *decryptStr = [[NSString alloc] initWithData:dataOut encoding:NSUTF8StringEncoding];
        return decryptStr;
    }
    free(buffer);
    return nil;
}

+(NSString *)AES128Encrypt1:(NSString *)content key32:(NSString *)key{
   
    //为结束符'\0' +1
    char keyPtr[[key length]+1];//kCCKeySizeAES128,kCCKeySizeAES256
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    //1，string转Data
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [contentData length];
    //密文长度 <= 明文程度 + BlockSize
    size_t bufferSize = dataLength + kCCBlockSizeAES128;//key：16位
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,//keyData.bytes Y|keyPtr N
                                          [key length],//keyData.length Y|key：16位（kCCBlockSizeAES128）
                                          NULL,
                                          contentData.bytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *dataOut = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //2，系统方法 Base64编码
        NSString *encryptStr = [dataOut base64EncodedStringWithOptions:0];
        return encryptStr;
    }
    free(buffer);
    return nil;
}

+(NSString *)AES128Decrypt1:(NSString *)content key32:(NSString *)key{
   
    //为结束符'\0' +1
    char keyPtr[[key length]+1];//kCCKeySizeAES128,kCCKeySizeAES256
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    //1，string转Data Base64解码
    NSData *contentData = [[NSData alloc]initWithBase64EncodedString:content options:0];
    NSUInteger contentDataLength = [contentData length];
    //密文长度 <= 明文程度 + BlockSize
    size_t bufferSize = contentDataLength + kCCBlockSizeAES128;//key：16位
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,//ECB
                                          keyPtr,//key
                                          [key length],//key.length=16（kCCBlockSizeAES128）
                                          NULL,//ECB时iv为空
                                          contentData.bytes,
                                          contentDataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *dataOut = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        //2，data encode
        NSString *decryptStr = [[NSString alloc] initWithData:dataOut encoding:NSUTF8StringEncoding];
        return decryptStr;
    }
    free(buffer);
    return nil;
}


+(NSString *)AES128Encrypt:(NSString *)content key:(NSString *)key{
    
    //string转Data
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"data is: %@",data);
    NSUInteger dataLength = [contentData length];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    //为结束符'\0' +1
    char keyPtr[kCCKeySizeAES128+1];
    //char keyPtr[keyData.length + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    // size_t bufferSize = dataLength + keyData.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;//key：16位
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,//keyData.bytes Y|keyPtr N
                                          kCCBlockSizeAES128,//keyData.length Y|key：16位（kCCBlockSizeAES128）
                                          NULL,
                                          contentData.bytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *dataOut = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [self base64EncodingWithData:dataOut LineLength:0];
    }
    free(buffer);
    return nil;
}





+ (NSString *) base64EncodingWithData:(NSData *)data LineLength:(unsigned int) lineLength {
    const unsigned char    *bytes = [data bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:[data length]];
    unsigned long ixtext = 0;
    unsigned long lentext = [data length];
    long ctremaining = 0;
    unsigned char inbuf[3], outbuf[4];
    short i = 0;
    short charsonline = 0, ctcopy = 0;
    unsigned long ix = 0;
    
    while( YES ) {
        ctremaining = lentext - ixtext;
        if( ctremaining <= 0 ) break;
        
        for( i = 0; i < 3; i++ ) {
            ix = ixtext + i;
            if( ix < lentext ) inbuf[i] = bytes[ix];
            else inbuf [i] = 0;
        }
        
        outbuf [0] = (inbuf [0] & 0xFC) >> 2;
        outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
        outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
        outbuf [3] = inbuf [2] & 0x3F;
        ctcopy = 4;
        
        switch( ctremaining ) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for( i = 0; i < ctcopy; i++ )
            [result appendFormat:@"%c", encodingTable[outbuf[i]]];
        
        for( i = ctcopy; i < 4; i++ )
            [result appendFormat:@"%c",'='];
        
        ixtext += 3;
        charsonline += 4;
        
        if( lineLength > 0 ) {
            if (charsonline >= lineLength) {
                charsonline = 0;
                [result appendString:@"\n"];
            }
        }
    }
    
    return result;
}


+ (NSData *) dataWithBase64EncodedString:(NSString *) string {
    NSData *result = [self base64EncodedString:string];
    return result;
}

+ (id) base64EncodedString:(NSString *) string {
    if (string == nil)
//        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL) // Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX) // Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1) // At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        // Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}




@end
