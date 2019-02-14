//
//  EaseBlankPageView.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/30.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "EaseBlankPageView.h"

@implementation EaseBlankPageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
//注意：这边分为两种，一种是请求出现错误时显示，并有一个刷新的按键，另外一种就是当前表格没有数据时显示的，并且进行的分类

-(void)configWityType:(EaseBlankPageType)blankPageType
              hasData:(BOOL)hasData
             hasError:(BOOL)hasError
    reloadButtonBlock:(void (^)(id))reloadBlock{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    self.alpha = 1.0;
    //图片
    if (!_monkeyImageView) {
        _monkeyImageView = [[UIImageView alloc]init];
        [self addSubview:_monkeyImageView];
    }
    [_monkeyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(100);
    }];
    
    //文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:17];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_tipLabel sizeToFit];
        [self addSubview:_tipLabel];
    }
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_monkeyImageView.mas_bottom).offset(10);
    }];
    //刷新按钮
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_reloadButton];
        
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_tipLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(130, 40));
        }];
    }
    
    _reloadButton.hidden = NO;
    _reloadButtonBlock = reloadBlock;
    
    if (hasError) {
        //加载失败
        [_monkeyImageView setImage:[UIImage imageNamed:@""]];
        _tipLabel.text = @"网络异常,加载失败";
        
    }else{
        //没有数据
        if (_reloadButton) {
            _reloadButton.hidden = YES;
        }
        
        NSString *imageName, *tipStr;
        switch (blankPageType) {
            case EaseBlankPageTypeActivity://项目动态
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"这里还什么都没有\n赶快起来弄出一点动静吧";
            }
                break;
            case EaseBlankPageTypeTask://任务列表
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"这里还没有任务\n赶快起来为团队做点贡献吧";
            }
                break;
            case EaseBlankPageTypeTopic://讨论列表
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"这里怎么空空的\n发个讨论让它热闹点吧";
            }
                break;
            
            case EaseBlankPageTypeProject://项目列表（自己的）
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"您还木有项目呢，赶快起来创建吧～";
            }
                break;
           
            case EaseBlankPageTypePrivateMsg://私信列表
            {
                imageName = @"blankpage_image_Hi";
                tipStr = @"无私信\n打个招呼吧～";
            }
                break;
            default://其它页面（这里没有提到的页面，都属于其它）
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"这里还什么都没有\n赶快起来弄出一点动静吧";
            }
                break;
        }
        
        [_monkeyImageView setImage:[UIImage imageNamed:imageName]];
        _tipLabel.text = tipStr;
        
        
    }
    
    
    
}

/**
 重新加载 按钮点击方法实现

 */
-(void)reloadButtonAction:(UIButton *)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_reloadButtonBlock) {
            
            _reloadButtonBlock(sender);
        }
    });
}

@end
