//
//  LoginProtocol.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/27.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginProtocol <NSObject>

@optional
/*
 这里简单实现一个登陆功能,将用户登录后的账号密码传递出去,有代理来处理具体登陆细节.
 
 */

-(void)userLoginWithUsername:(NSString *)username password:(NSString *)password;


@end
