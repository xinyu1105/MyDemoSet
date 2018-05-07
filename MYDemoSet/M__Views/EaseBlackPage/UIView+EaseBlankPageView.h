//
//  UIView+EaseBlankPageView.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/4.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseBlankPageView.h"
@interface UIView (EaseBlankPageView)
@property (nonatomic, strong) EaseBlankPageView *blankPageView;

-(void)configWityType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;

@end
