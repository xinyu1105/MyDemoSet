//
//  EaseBlankPageView.h
//  MYDemoSet
//
//  Created by Block on 2018/3/30.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,EaseBlankPageType) {
    EaseBlankPageTypeActivity = 0,//项目动态
    EaseBlankPageTypeTask,//任务列表
    EaseBlankPageTypeTopic,//讨论列表
    EaseBlankPageTypeProject,//项目列表
    EaseBlankPageTypePrivateMsg//私信列表....
};

@interface EaseBlankPageView : UIView
//空白页提示图片
@property (nonatomic, strong) UIImageView *monkeyImageView;
//空白页提示文字
@property (nonatomic, strong) UILabel *tipLabel;
//空白页重新刷新按钮
@property (nonatomic, strong) UIButton *reloadButton;
//带参数block
@property (nonatomic, copy) void (^reloadButtonBlock)(id sender);


-(void)configWityType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;

@end
