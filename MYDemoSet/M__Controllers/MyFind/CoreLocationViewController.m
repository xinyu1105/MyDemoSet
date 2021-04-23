//
//  CoreLocationViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2020/12/7.
//  Copyright © 2020 pengjiaxin. All rights reserved.
//

#import "CoreLocationViewController.h"
#import "CoreLocationObject.h"

#define kScreenW CGRectGetWidth([UIScreen mainScreen].bounds)

@interface CoreLocationViewController ()
@property (nonatomic, readwrite, strong) UILabel *label1;
@end

@implementation CoreLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //测试Label和Button
    _label1 = [[UILabel alloc] init];
    _label1.bounds = CGRectMake(0, 0, kScreenW - 30, 50);
    _label1.center = CGPointMake(kScreenW / 2, 100);
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.numberOfLines = 0;
    _label1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_label1];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.bounds = CGRectMake(0, 80, 150, 30);
    btn.center = CGPointMake(kScreenW / 2, 180);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"定位按钮1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(50, 220, 96, 96);
    btn1.backgroundColor = [UIColor redColor];
    btn1.layer.cornerRadius = 50;
    [self.view addSubview:btn1];
    
    [btn1 setImage:[UIImage imageNamed:@"btnImage"] forState:UIControlStateNormal];
    btn1.clipsToBounds = YES;
    
}


- (void)click1 {
    __weak typeof(self) weakSelf = self;
    [[CoreLocationObject sharedInstance] startWithCompletionHandler:^(LocationModel * _Nullable model) {
        NSLog(@"经度:%@--纬度:%@--地址:%@",model.longitude,model.latitude,model.address);
        weakSelf.label1.text = model.address;
    }];
    
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
