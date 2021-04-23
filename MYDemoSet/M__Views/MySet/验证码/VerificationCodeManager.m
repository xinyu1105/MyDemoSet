//
//  VerificationCodeManager.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/3/16.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import "VerificationCodeManager.h"
#import "VerificationCodeView.h"

@implementation VerificationCodeManager

/**
 单利
 */
+(instancetype)defauleVerificationCodeManager{
    static VerificationCodeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VerificationCodeManager alloc]init];
    });
    return manager;
}

/**
 显示VerificationCodeView
 */
-(void)showVerificationCodeView{
    //请求接口获取图片
    [self getDataWithCategary:@"default" siteId:@"2"];
        
}

-(void)showVerificationCodeViewWithData:(NSDictionary *)dict{
    
    VerificationCodeView *codeView = [[VerificationCodeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [codeView showCodeView];
    
    codeView.bgImageUrl = dict[@"Bg"];
    codeView.sliderImageUrl = dict[@"Slider"];
}

/**
 获取bg和Slider图片
 */
-(void)getDataWithCategary:(NSString *)cg siteId:(NSString *)si{
    NSString * ts = [self TCGetDateTimeToMilliSeconds:[NSDate date]];
    NSString *urlStr = [NSString stringWithFormat:@"https://nc.tiancity.com/captcha/get?Category=%@&SiteId=%@&ts=%@",cg,si,ts];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                return;
            }
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"%@",jsonDict);            
            NSLog(@"%@",jsonDict[@"Data"]);
            NSLog(@"%@",jsonDict[@"Data"][@"Bg"]);
            NSLog(@"%@",jsonDict[@"Data"][@"Slider"]);
            NSLog(@"%@",jsonDict[@"Data"][@"Token"]);
            NSLog(@"%@",jsonDict[@"Data"][@"Key"]);
            
            [self showVerificationCodeViewWithData:jsonDict[@"Data"]];
        
        });
    }];

    [task resume];
    
}

//时间戳
//将NSDate类型的时间转换为时间戳,从1970/1/1开始

-(NSString *)TCGetDateTimeToMilliSeconds:(NSDate *)datetime{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    //毫秒
    long long totalMilliseconds = interval*1000 ;
    NSString *str = [NSString stringWithFormat:@"%lld",totalMilliseconds];
    return str;
}
@end
