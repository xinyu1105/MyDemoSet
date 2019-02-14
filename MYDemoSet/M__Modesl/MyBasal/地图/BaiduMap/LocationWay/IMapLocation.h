//
//  IMapLocation.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/2.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
//抽象地图标准协议
@protocol IMapLocation <NSObject>


//开始定位
-(void)start;

//结束定位
-(void)stop;
@end
