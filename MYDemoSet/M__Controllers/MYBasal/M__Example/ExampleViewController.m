//
//  ExampleViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/29.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "ExampleViewController.h"

#define ZFBundle_Name @"M_Images.bundle"
#define ZFBundle_Path [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:ZFBundle_Name]
#define ZFBundle [NSBundle bundleWithPath:ZFBundle_Path]

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 30, 30);
    [self.view addSubview:button];
    
//    if (@available(iOS 8.0, *)) {
//        [button setImage:[UIImage imageNamed:@"close" inBundle:ZFBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
//    } else {
//        // Fallback on earlier versions
//    }
    
    
    NSString *bundlePath = [[ NSBundle mainBundle] pathForResource:@"M_Images" ofType :@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:[NSString stringWithFormat:@"%@",@"followgame_selected"] ofType:@"png"];
    UIImage*image_1=[UIImage imageWithContentsOfFile:img_path];
    [button setImage:image_1 forState:UIControlStateNormal];
    

    
   
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
