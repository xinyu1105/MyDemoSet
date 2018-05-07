//
//  CustomFloatButton.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/23.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
//枚举类型
typedef NS_ENUM(NSInteger ,NSFloatButtonTouchType){
    NSFloatButtonTouchTypeNone = 0,//可以在屏幕内随意移动
    NSFloatButtonTouchTypeVerticalScroll,//只能竖直移动
    NSFloatButtonTouchTypeHorizontalScroll,//只能水平移动
};

@interface CustomFloatButton : UIButton


+(instancetype)createFloatButtonWithType:(NSFloatButtonTouchType)type
                                   Frame:(CGRect)frame
                                   title:(NSString *)title
                              titleColor:(UIColor *)titleColor
                               titleFont:(UIFont *)titleFont
                         backgroundColor:(UIColor *)backgroundColor
                         backgroundImage:(UIImage *)backgroundImage;


@end
