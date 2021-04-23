//
//  BaiduProtocolMapViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/11.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaiduProtocolMapViewController : BaseViewController

@end

/**
 第三步：快速实现百度地图设计（重点）->完成
 首先：分析问题？
 百度地图->地图显示->BMKMapView : UIView
 高德地图->地图显示->MAMapView : UIView
 
 其次：降低耦合？解决方案：抽象他的爸爸（抽象为协议）->定义地图标准->Protocol->IMapView
 
 最后：实现百度地图显示->解耦和？名字：BaiduMapView
 */
 
