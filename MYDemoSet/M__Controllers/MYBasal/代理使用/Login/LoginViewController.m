//
//  LoginViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/27.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"委托方";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* btn=[[UIButton alloc] init];
    btn.frame=CGRectMake(100, 240, 40, 40);
    [btn setTitle:@"等陆" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"123456789");
    
    
}

/**
 登录按钮点击方法实现
 */
-(void)loginButtonAction{
    //判断代理对象是否实现这个方法,没有实现会导致崩溃
    if ([self.delegate respondsToSelector:@selector(userLoginWithUsername:password:)]) {
        //调用代理对象的登录方法,代理对象去实现登录方法
        [self.delegate userLoginWithUsername:@"13592456645" password:@"123456"];
    }
    
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
