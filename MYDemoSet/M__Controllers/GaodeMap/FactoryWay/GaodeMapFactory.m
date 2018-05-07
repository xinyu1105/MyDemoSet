//
//  GaodeMapFactory.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/2.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "GaodeMapFactory.h"
#import "GaodeMapView.h"
@implementation GaodeMapFactory
-(instancetype)init{
    self = [super init];
    if (self) {
        [AMapServices sharedServices].apiKey = @"f89ea7bf07ed617adb5453da6eb8c649";
    }
    return self;
}

-(id<IMapViewProtocol>)getMapView:(CGRect)frame{
    return [[GaodeMapView alloc]initWithFrame:frame];
}
@end
