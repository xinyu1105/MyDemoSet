//
//  Global.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/27.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#ifndef Global_h
#define Global_h


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//状态栏高度iPhone 8：20/iPhone X：44
#define StatusHeight ([UIApplication sharedApplication].statusBarFrame.size.height)

//CGFloat statusBarHeight = 0.f;
//if (@available(iOS 13.0, *)) {
//    statusBarHeight = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame.size.height;
//} else {
//    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
//}
//iPhoneX、iPhoneXS
#define  isIphoneX_XS_11Pro   (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
//iPhoneXR 、 iPhoneXSMax
#define  isIphoneXR_XSMax_11_11ProMax (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
//iPhone12 、 iPhone12Pro
#define  isIphone12_12Pro (SCREEN_WIDTH == 390.f && SCREEN_HEIGHT == 844.f ? YES : NO)
//iPhone12ProMax
#define  isIphone12ProMax (SCREEN_WIDTH == 428.f && SCREEN_HEIGHT == 926.f ? YES : NO)
//iPhone12 mini
#define  isIphone12mini (SCREEN_WIDTH == 360.f && SCREEN_HEIGHT == 780.f ? YES : NO)
//异性全面屏
#define  isFullScreen  (isIphoneX_XS_11Pro || isIphoneXR_XSMax_11_11ProMax || isIphone12_12Pro || isIphone12ProMax || isIphone12mini)

//导航条+状态栏
#define StatusAndNaviHeight (StatusHeight + 44)

//设备底部安全距离配置
#define iPhoneXSafeBottomMargin (isFullScreen ? 34.f : 0.f)

#define TabbarHeight  (iPhoneXSafeBottomMargin + 49) // 适配iPhone x 底栏高度

#define ScreenWidthScale (SCREEN_WIDTH/320)
#define ScreenHeightScale (SCREEN_HEIGHT/568)

#define kRealWidth(with) ((with)*(SCREEN_WIDTH/375.0f))
#define kRealHeight(height)   (isFullScreen?(height)*(667.0/667.0f):(height)*(SCREEN_HEIGHT/667.0f))

#define UM_AppKey (@"554745cd67e58e694f00258c")
#define UMShareWeixinAppID (@"wx4f349bf69229013d")
#define UMShareWeixinAppSecret (@"d4624c36b6795d1d99dcf0547af5443d")
#define TCUMShareAppRedirectURL (@"http://sec.tiancity.com/homepage/")


#endif /* Global_h */
