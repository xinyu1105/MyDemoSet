//
//  LoginDelegateViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/27.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "LoginDelegateViewController.h"
#import "LoginViewController.h"
//引入协议
//遵守协议
#import "LoginProtocol.h"
@interface LoginDelegateViewController ()<LoginProtocol>

@end

@implementation LoginDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"代理方";
    
    UILabel *tapLabel = [[UILabel alloc]init];
    tapLabel.text = @"点击屏幕";
    tapLabel.textAlignment = NSTextAlignmentCenter;
    tapLabel.numberOfLines = 0;
    [tapLabel sizeToFit];
    [self.view addSubview:tapLabel];

    [tapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    //指定代理
    loginVC.delegate = self;
    [self.navigationController pushViewController:loginVC animated:YES];
}

/**
 代理方实现具体登录细节

 @param username 用户名
 @param password 密码
 */
-(void)userLoginWithUsername:(NSString *)username password:(NSString *)password{
    NSLog(@"username : %@, password : %@", username, password);
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
