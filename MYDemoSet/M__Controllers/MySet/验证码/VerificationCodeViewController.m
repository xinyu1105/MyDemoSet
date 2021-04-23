//
//  VerificationCodeViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/3/12.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import "VerificationCodeViewController.h"
#import "VerificationCodeManager.h"
#import "VerificationCodeView.h"
@interface VerificationCodeViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITextField *userNameTextField;

@end

@implementation VerificationCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   VerificationCodeView *codeView = [[VerificationCodeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
   [codeView showCodeView];
    
    // [[VerificationCodeManager defauleVerificationCodeManager] showVerificationCodeView];
    

    
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
