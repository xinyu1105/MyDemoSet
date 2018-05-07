//
//  CustomFloatButton.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/23.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "CustomFloatButton.h"

@implementation CustomFloatButton{
    NSFloatButtonTouchType _type;
}


-(instancetype)initWithType:(NSFloatButtonTouchType)type
                      Frame:(CGRect)frame
                      title:(NSString *)title
                 titleColor:(UIColor *)titleColor
                  titleFont:(UIFont *)titleFont
            backgroundColor:(UIColor *)backgroundColor
            backgroundImage:(UIImage *)backgroundImage{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        //UIButton换行显示
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.textColor = titleColor;
        self.titleLabel.font = titleFont;
        [self setBackgroundColor:backgroundColor];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        //添加拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        
        
        
    }
    return self;
    
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    
#pragma mark 难点1
    //translationInView:获取到的是手指点击屏幕实时的坐标点；
    CGPoint point = [pan translationInView:self];
    
    CGRect originFrame = self.frame;
 
    switch (_type) {
        case NSFloatButtonTouchTypeNone:{
            originFrame = [self changeXWithFrame:originFrame Point:point];
            originFrame = [self changeYWithFrame:originFrame Point:point];
        
            break;
        }
        case NSFloatButtonTouchTypeHorizontalScroll:{
            originFrame = [self changeYWithFrame:originFrame Point:point];
            
            break;
        }
        case NSFloatButtonTouchTypeVerticalScroll:{
            originFrame = [self changeXWithFrame:originFrame Point:point];
            
            break;
        }
    }
    
    self.frame = originFrame;
#pragma mark 难点2
    //清空位移数据,避免拖拽事件的位移叠加
    [pan setTranslation:CGPointZero inView:self];
    
#pragma mark 难点3
    //记录button是否屏幕越界
    
    UIButton *button = (UIButton *)pan.view;
    if (pan.state == UIGestureRecognizerStateBegan) {
        button.enabled = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
    }else{
        //越界处理
        [self over];
        
        button.enabled = YES;
    }
}
/**
 拖动改变控件的竖直方向x值
 */
-(CGRect)changeXWithFrame:(CGRect)originalFrame Point:(CGPoint)point{
    BOOL q1 = originalFrame.origin.x >=0;
    BOOL q2 = originalFrame.origin.x + originalFrame.size.width <= SCREEN_WIDTH;

    if (q1 && q2) {
        originalFrame.origin.x +=point.x;
    }
    return originalFrame;
}

/**
拖动改变控件的竖直方向y值
 */
-(CGRect)changeYWithFrame:(CGRect)originalFrame Point:(CGPoint)point{
    BOOL q1 = originalFrame.origin.y >=0;
    BOOL q2 = originalFrame.origin.y + originalFrame.size.height <= SCREEN_HEIGHT;
    
    if (q1 && q2) {
        originalFrame.origin.y +=point.y;
    }
    return originalFrame;
}


//屏幕越界处理

-(void)over{
    CGRect frame = self.frame;
    //记录button是否屏幕越界
    BOOL isOver = NO;
    
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
        isOver = YES;
    }else if (frame.origin.x + frame.size.width >SCREEN_WIDTH){
        frame.origin.x = SCREEN_WIDTH - frame.size.width;
        isOver = YES;
    }
    
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
        isOver = YES;
    }else if (frame.origin.y + frame.size.height >SCREEN_HEIGHT){
        frame.origin.y = SCREEN_HEIGHT - frame.size.height;
        isOver = YES;
    }
    
    if (isOver) {
        //如果越界-拉回来
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
    }
    
}

+(instancetype)createFloatButtonWithType:(NSFloatButtonTouchType)type
                                   Frame:(CGRect)frame
                                   title:(NSString *)title
                              titleColor:(UIColor *)titleColor
                               titleFont:(UIFont *)titleFont
                         backgroundColor:(UIColor *)backgroundColor
                         backgroundImage:(UIImage *)backgroundImage{
    
    return [[self alloc]initWithType:type Frame:frame title:title titleColor:titleColor titleFont:titleFont backgroundColor:backgroundColor backgroundImage:backgroundImage];
    
}

@end
