//
//  BaiduMapFactory.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/12.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaiduMapFactory.h"
#import "BaiduMapView.h"
@implementation BaiduMapFactory

-(instancetype)init{
    self = [super init];
    if (self) {
        //初始化百度SDK
        
        BMKMapManager *mapManager = [[BMKMapManager alloc]init];
        // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
        BOOL ret = [mapManager start:@"LIofsrqPmLMlTZ2dGPLxd5oRVhoC0umu"  generalDelegate:nil];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
        
    }
    return self;
}

-(id)getMapView:(CGRect)frame{
    return [[BaiduMapView alloc] initWithFrame:frame];
}

@end
