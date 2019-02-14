//
//  FloatButton_ViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/23.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "FloatButton_ViewController.h"

@interface FloatButton_ViewController ()

@end

@implementation FloatButton_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self addCustomFloatButton];
}
-(void)addCustomFloatButton{
    CGFloat touchW = 120;
    CGFloat touchX = SCREEN_WIDTH - touchW;
    CGFloat touchY = 43;
    CGFloat touchH = 49;
    
    NSString *versionStr = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    NSString *buildStr = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"];
    
    NSString *title = [NSString stringWithFormat:@"Ver:%@ 测试\nBuild:%@",versionStr,buildStr];
    CGRect frame = CGRectMake(touchX, touchY, touchW, touchH);
    
    CustomFloatButton *floatButton = [CustomFloatButton createFloatButtonWithType:NSFloatButtonTouchTypeNone Frame:frame title:title titleColor:[UIColor redColor] titleFont:[UIFont systemFontOfSize:13] backgroundColor:nil backgroundImage:[UIImage imageNamed:@"floatButtonBackgroundImage"]];
    [self.view addSubview:floatButton];
    
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
