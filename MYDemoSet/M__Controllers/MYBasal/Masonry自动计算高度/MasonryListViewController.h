//
//  TableListViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/13.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"

@interface MasonryListViewController : BaseViewController

@end

/*
 
 #pragma mark 1给控件添加约束是关键
 
 [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.left.equalTo(self).offset(10);
 make.right.equalTo(self).offset(-10);
 }];
 
 [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.right.equalTo(self.titleLabel);
 make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
 }];
 
 [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
 make.bottom.left.right.equalTo(self);
 make.height.mas_equalTo(1);
 }];
 
 #pragma mark 2关键点
 [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.right.bottom.equalTo(self.view);
 make.top.equalTo(self.view).offset(20);
 }];
 
 #pragma mark 3关键点设置估算高度
 _tableView.estimatedRowHeight = 20;
 
 
 
 
 
 */











