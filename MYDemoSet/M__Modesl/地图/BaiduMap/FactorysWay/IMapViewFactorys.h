//
//  IMapViewFactorys.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/2.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IMapViewProtocol.h"
//地图工厂标准协议->抽象工厂模式

#import "IMapLocation.h"

@protocol IMapViewFactorys <NSObject>


/**
第一条流水线 百度地图
 */
-(id<IMapViewProtocol>)getMapView:(CGRect)frame;

/**
第二条流水线 定位模块
 */
-(id<IMapLocation>)getMapLocation;
@end
