//
//  BaiduMapView.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/11.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaiduMapView.h"

@interface BaiduMapView()
@property (nonatomic, strong) BMKMapView *mapView;
@end


@implementation BaiduMapView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _mapView = [[BMKMapView alloc]initWithFrame:frame];
        
    }
    return self;
}

-(UIView *)getView{
    return _mapView;
}
@end
