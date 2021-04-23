//
//  VerificationCodeManager.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/3/16.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerificationCodeManager : NSObject

/**
 单利
 */
+(instancetype)defauleVerificationCodeManager;

/**
 显示VerificationCodeView
 */
-(void)showVerificationCodeView;

/**
 请求接口获取bg和Slider图片
 */
-(void)getDataWithCategary:(NSString *)cg siteId:(NSString *)si;

@end

NS_ASSUME_NONNULL_END
