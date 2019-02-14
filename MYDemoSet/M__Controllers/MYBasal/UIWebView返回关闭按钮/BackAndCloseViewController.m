//
//  BackAndCloseViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/1/23.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import "BackAndCloseViewController.h"
#import "BackAndCloseWebViewController.h"

#import "WKWebViewController.h"
@interface BackAndCloseViewController ()

@end

@implementation BackAndCloseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setTitle:@"点击加载UIWebView" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [clickButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clickButton.backgroundColor = [UIColor lightGrayColor];
    [clickButton sizeToFit];
    [self.view addSubview:clickButton];
    
    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];

}

/**
 点击跳转到UIWebView

 @param button button description
 */
- (void)clickButtonAction:(UIButton *)button{
//    BackAndCloseWebViewController *backWebVC = [[BackAndCloseWebViewController alloc]init];
//    [self.navigationController pushViewController:backWebVC animated:YES];
//
    
    
    WKWebViewController *backWebVC = [[WKWebViewController alloc]init];
    [self.navigationController pushViewController:backWebVC animated:YES];
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
