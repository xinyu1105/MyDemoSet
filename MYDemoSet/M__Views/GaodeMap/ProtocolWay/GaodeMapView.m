//
//  GaodeProtocolMapView.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/11.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "GaodeMapView.h"

@interface GaodeMapView ()
@property (nonatomic, strong)  MAMapView * mapView;
@end


@implementation GaodeMapView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _mapView = [[MAMapView alloc]initWithFrame:frame];
    }
    return self;
}

-(UIView *)getView{
    return _mapView;
}
@end
