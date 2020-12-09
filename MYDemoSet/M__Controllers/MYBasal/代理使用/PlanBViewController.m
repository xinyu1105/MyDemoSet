//
//  PlanBViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/24.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "PlanBViewController.h"

@interface PlanBViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation PlanBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"B界面";
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _textField.placeholder = @"请输入";
    _textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textField];

    
    UIButton* btn=[[UIButton alloc] init];
    btn.frame=CGRectMake(100, 240, 40, 40);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

/**
 button点击方法
 代理传值
 */
-(void)sendButtonAction{
    //首次判断代理是否存在，并在代理能够响应代理方法时才执行代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendName:)]) {
        
        [self.delegate sendName:self.textField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
