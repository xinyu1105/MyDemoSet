//
//  NSString+URLEncode.m
//  TianCityAccountManager
//
//  Created by pengjiaxin on 16/10/9.
//  Copyright © 2016年 pengjiaxin. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)

/**
 URLEncode
 */
- (NSString *)URLEncode{
    //deprecated in iOS 9.0
    /*
    NSString *result =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              CFSTR("!*'();:@&;=+$,/?%#[] "),
                                                              kCFStringEncodingUTF8));
    return [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    */
    
    NSString *charactersToEscape = @"!*'();:@&;=+$,/?%#[] ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

/**
 URLDecode
 */
- (NSString *)URLDecode{
    
   
    //deprecated in iOS 9.0
    /*
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    
    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

     */
    //deprecated in iOS 9.0
    /*
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                        CFSTR(""),
                                                                                                                        CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
       return decodedString;
    
    */
    return [self stringByRemovingPercentEncoding];
}




@end
