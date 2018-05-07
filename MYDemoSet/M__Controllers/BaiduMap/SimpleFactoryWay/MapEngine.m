//
//  MapEngine.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/2.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "MapEngine.h"

#import "BaiduMapFactory.h"
#import "GaodeMapFactory.h"

@implementation MapEngine

-(id<IMapViewFactory>)getMapFactory{
    return [[BaiduMapFactory alloc]init];
}
@end
