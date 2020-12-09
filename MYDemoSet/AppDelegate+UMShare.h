//
//  AppDelegate+UMShare.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2020/12/2.
//  Copyright © 2020 pengjiaxin. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (UMShare)
/**
 UMShare注册

 @param launchOptions 应用程序
 */
-(void)registerUMShare:(NSDictionary *)launchOptions;

/**
 调用友盟相关方法
 
 @param controller 当前视图控件
 */
//- (void)getUMShareRelevantMethodsWithCurrentViewController:(UIViewController *)controller;


/**
 调用友盟相关方法(带参)
 
 @param controller  当前视图控件
 @param image        参数(shareType:分享类型(默认:base,若需要自定义则将 base 变更为其它) & descr:备注说明文字 & webpageUrl:跳转链接地址)
 */
- (void)getUMShareRelevantMethodsWithCurrentViewController:(UIViewController *)controller WithImage:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
