//
//  CustomMainViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/6/28.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "CustomMainViewController.h"
#import "CustomCameraViewController.h"
@interface CustomMainViewController ()
@property (nonatomic, strong) UILabel *tapLabel;

@end

@implementation CustomMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自定义相机";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    
}
-(void)createUI{
    //UILabel
    self.tapLabel = [[UILabel alloc]init];
    _tapLabel.text = @"点击屏幕调用系统相机";
    _tapLabel.font = [UIFont systemFontOfSize:14];
    [_tapLabel sizeToFit];
    [self.view addSubview:_tapLabel];
    
    [_tapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //UIImageView
    self.tapImageView = [[UIImageView alloc]init];
    _tapImageView.userInteractionEnabled = YES;
    
    //图片占满整个父容器,并且不变形
    _tapImageView.contentMode = UIViewContentModeScaleAspectFill;
    _tapImageView.clipsToBounds = YES;
    
    [self.view addSubview:_tapImageView];
    
    [_tapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tapLabel.mas_bottom).offset(20);
        make.centerX.equalTo(_tapLabel.mas_centerX);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
    }];
    //手势
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.tapImageView addGestureRecognizer:tapGesture];
    
}
/**
 图片手势点击方法实现
 */
-(void)tapGestureAction:(UITapGestureRecognizer *)tap{
    CustomCameraViewController *cameraVC = [[CustomCameraViewController alloc]init];
    [self.navigationController pushViewController:cameraVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
