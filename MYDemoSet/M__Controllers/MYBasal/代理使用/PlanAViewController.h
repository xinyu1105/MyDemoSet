//
//  PlanAViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/24.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"
//代理类
@interface PlanAViewController : BaseViewController

@end

/*
 从A界面 push 到B界面 ;返回A界面时, 把B界面字符串 name 传递到A界面显示;
 
 B传值给A
 
 逆传
 
 A作为B的代理,在代理方法中接收B传过来的值
 
 A:代理方：
 B.委托方：
 
 
 代理方法是用的比较多的，适用于任意界面之间传值，只需要声明实现代理方法，就可以获取传递过来的值
 
 
 https://blog.csdn.net/leemboy/article/details/78665104
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
