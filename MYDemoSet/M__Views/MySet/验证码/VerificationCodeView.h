//
//  VerificationCodeView.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/3/12.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    ViewTypePuzzleAlert = 0,
    ViewTypePuzzleView,
}ViewType;

@interface VerificationCodeView : UIView

@property (nonatomic, copy) NSString *bgImageUrl;
@property (nonatomic, copy) NSString *sliderImageUrl;

/**
 显示验证码弹框
 */
-(void)showCodeView;

/**
 显示验证码界面
 
 */
-(void)showVerificationCodeViewWithViewType:(ViewType)viewType;

@end

@interface TCSlider : UISlider


@end


NS_ASSUME_NONNULL_END
