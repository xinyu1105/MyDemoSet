//
//  UMShareA.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/6/26.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 1，导入SDK
 
 UMCommon.framework
 UMShare.framework
 UMSocialUI
 SocialLibraries
 
 2，在Other Linker Flags加入-ObjC
 
 
3,导入系统依赖库
 libsqlite3.tbd
 CoreGraphics.framework
 
 4，添加微信依赖库
 SystemConfiguration.framework
 CoreTelephony.framework
 libsqlite3.tbd
 libc++.tbd
 libz.tbd
 （以上均已添加）
 5,配置SSO白名单
 <key>LSApplicationQueriesSchemes</key>
 <array>
 <!-- 微信 URL Scheme 白名单-->
 <string>wechat</string>
 <string>weixin</string>
 
 <array>
 
 6，配置URL Scheme
 
 微信appkey
 
 AppID  wx4f349bf69229013d
 
 com.MYDemoSet
 
 com.tiancity.sec
 
 
 
 
 */

