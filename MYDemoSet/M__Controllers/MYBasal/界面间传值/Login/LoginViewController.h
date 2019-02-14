//
//  LoginViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/27.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginProtocol.h"

/*
 当前类是委托类,用户登录后,让代理对象去实现登陆的具体细节,委托类不需要知道其中实现的据图细节.
 */

@interface LoginViewController : BaseViewController
//通过属性来设置代理对象
@property (nonatomic, weak) id delegate;

@end
