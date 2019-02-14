//
//  MainTypeTableViewCell.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/7/10.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTypeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
//-(void)configureCellWithModel:(Model:)model;
-(void)configureCellWithTitle:(NSString *)title;

@end
