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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ScreenWidthScale (SCREEN_WIDTH/320)
#define ScreenHeightScale (SCREEN_HEIGHT/568)
//
#define XWScreenWidthScale (SCREEN_WIDTH/375)
#define XWScreenHeightScale (SCREEN_HEIGHT/667)





#endif /* Global_h */
