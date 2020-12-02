//
//  Global.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/27.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//状态栏高度iPhone 8：20/iPhone X：44
#define StatusHeight ([UIApplication sharedApplication].statusBarFrame.size.height)
//是否是iPhone X
#define IsIphoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f?YES:NO)

//导航条+状态栏
#define StatusAndNaviHeight (StatusHeight + 44)

//设备底部安全距离配置
#define iPhoneXSafeBottomMargin (IsIphoneX ? 34.f : 0.f)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ScreenWidthScale (SCREEN_WIDTH/320)
#define ScreenHeightScale (SCREEN_HEIGHT/568)

#define kRealWidth(with) ((with)*(SCREEN_WIDTH/375.0f))
#define kRealHeight(height)   (IsIphoneX?(height)*(667.0/667.0f):(height)*(SCREEN_HEIGHT/667.0f))

#define UM_AppKey (@"554745cd67e58e694f00258c")
#define UMShareWeixinAppID (@"wx4f349bf69229013d")
#define UMShareWeixinAppSecret (@"d4624c36b6795d1d99dcf0547af5443d")
#define TCUMShareAppRedirectURL (@"http://sec.tiancity.com/homepage/")


#endif /* Global_h */
