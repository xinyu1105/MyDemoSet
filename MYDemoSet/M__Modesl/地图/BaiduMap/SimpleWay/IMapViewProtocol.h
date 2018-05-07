//
//  IMapViewProtocol.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/11.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
//地图标准协议
@protocol IMapViewProtocol <NSObject>

-(instancetype)initWithFrame:(CGRect)frame;

//定义标准
-(UIView *)getView;


@end
