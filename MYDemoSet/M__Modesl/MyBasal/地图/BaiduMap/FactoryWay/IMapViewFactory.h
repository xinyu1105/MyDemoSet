//
//  IMapViewFactory.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/12.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMapViewProtocol.h"
//地图工厂标准协议
@protocol IMapViewFactory <NSObject>


-(id<IMapViewProtocol>)getMapView:(CGRect)frame;



@end
