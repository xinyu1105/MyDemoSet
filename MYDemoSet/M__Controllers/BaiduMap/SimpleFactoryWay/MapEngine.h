//
//  MapEngine.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/2.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMapViewFactory.h"
@interface MapEngine : NSObject

-(id<IMapViewFactory>)getMapFactory;


@end