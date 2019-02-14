//
//  MasonryListTableViewCell.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/13.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "MasonryListTableViewCell.h"

@interface MasonryListTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation MasonryListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc]init];
    _detailLabel.numberOfLines = 0;
    _detailLabel.textColor = [UIColor darkGrayColor];
    _detailLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.detailLabel];
    
    self.bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.bottomLineView];
    
//    [self layoutSubview];
#pragma mark 1关键点 给控件添加约束是关键
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

/**
 给子视图添加约束
 */
-(void)layoutSubview{
  
}
#pragma  mark  - setter
//????
//-(void)setTitle:(NSString *)title{
//    _title = title;
//    _titleLabel.text = title;
//}
//
//-(void)setDetail:(NSString *)detail{
//    _detail = detail;
//    _detailLabel.text = detail;
//}

-(void)configureCellWithTitle:(NSString *)title DetailText:(NSString *)detailText{
    _titleLabel.text = title;
    _detailLabel.text = detailText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
