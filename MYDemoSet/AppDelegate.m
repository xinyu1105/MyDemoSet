//
//  AppDelegate.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/23.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTypeViewController.h"
#import "CustomFloatButton.h"
//5,
#import "BaiduMapFactory.h"

#import <UMShare/UMShare.h>
#import <UMCommonLog/UMCommonLogManager.h>
#import <UMCommon/UMCommon.h>


@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];
    //UM_AppKey
    [UMConfigure initWithAppkey:UM_AppKey channel:@"App Store"];
    
    // U-Share 平台设置
    [self configUSharePlatforms];
    [self confitUShareSettings];
    
    //1,快速集成百度地图
//    [self setBaiduSimpleMap];
    
    //2,快速集成高德地图
//    [self setGaodeSimpleMap];
    
    //3,快速实现百度地图设计
    
//    [self setBaiduProtocolMap];
    
    //4,快速实现高德地图设计
//    [self setGaodeProtocolMap];
    
    //5,SDK设计
    [self setBaiduMapWithFactory];

    
    MainTypeViewController *typeTVC = [[MainTypeViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:typeTVC];
    self.window.rootViewController = navi;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addCustomFloatButton];
    });
    
    
 
    
    return YES;
}

-(void)addCustomFloatButton{
    CGFloat touchW = 120;
    CGFloat touchX = 375 - touchW;
    CGFloat touchY = 43;
    CGFloat touchH = 49;
    
    NSString *versionStr = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    NSString *buildStr = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"];
    
    NSString *title = [NSString stringWithFormat:@"Ver:%@ 测试\nBuild:%@",versionStr,buildStr];
    CGRect frame = CGRectMake(touchX, touchY, touchW, touchH);
    
    CustomFloatButton *floatButton = [CustomFloatButton createFloatButtonWithType:NSFloatButtonTouchTypeNone Frame:frame title:title titleColor:[UIColor redColor] titleFont:[UIFont systemFontOfSize:13] backgroundColor:nil backgroundImage:[UIImage imageNamed:@"floatButtonBackgroundImage"]];
    [self.window addSubview:floatButton];
    
}

/**
 1,快速集成百度地图
 */
-(void)setBaiduSimpleMap{
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [mapManager start:@"LIofsrqPmLMlTZ2dGPLxd5oRVhoC0umu"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

/**
 2,快速集成高德地图
 */
-(void)setGaodeSimpleMap{
    [AMapServices sharedServices].apiKey = @"f89ea7bf07ed617adb5453da6eb8c649";
}


/**
 3,快速实现百度地图设计
 */
-(void)setBaiduProtocolMap{
    [self setBaiduSimpleMap];
}

-(void)setGaodeProtocolMap{
    [self setGaodeSimpleMap];
}

-(void)setBaiduMapWithFactory{
 
}
- (void)confitUShareSettings{
    /*
     * 打开图片水印
     */
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

-(void)configUSharePlatforms{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:UMShareWeixinAppID appSecret:UMShareWeixinAppSecret redirectURL:@"http://mobile.umeng.com/social"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}














- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
