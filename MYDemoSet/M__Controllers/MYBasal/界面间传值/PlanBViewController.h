//
//  PlanBViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/24.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"
//委托类
//1,声明代理
@protocol sendStringDelegate<NSObject>

@optional
-(void)sendName:(NSString *)nameStr;

@end


@interface PlanBViewController : BaseViewController

//通过属性来设置代理对象
@property (nonatomic, weak) id<sendStringDelegate> delegate;





@end
