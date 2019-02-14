//
//  NSDateTool.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/13.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "NSDateTool.h"

@implementation NSDateTool

+(void)getEastEightAreaCurrentTime{
    
    NSDate * date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    设置东8区
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];
    NSString* now = [df stringFromDate:date];
    //    正确获取天朝时间
    NSLog(@"EastEightAreaTime=%@",now);
    
}


@end
