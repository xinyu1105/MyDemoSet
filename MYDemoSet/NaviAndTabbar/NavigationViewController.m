//
//  NavigationViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/1/18.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (([self.viewControllers count] >0 )) {
        
//        if ([viewController isKindOfClass:[OptimizeNowViewController class]]||[viewController isKindOfClass:[GameNewsViewController class]]) {
//            viewController.hidesBottomBarWhenPushed = NO;
//        }else{
        
            viewController.hidesBottomBarWhenPushed = YES;
            
//        }
        
#pragma mark 可以在这里定义返回按钮等
        /*
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
         viewController.navigationItem.leftBarButtonItem = backItem;
         */
        
    }
    //一定要写在最后，要不然无效
    
    [super pushViewController:viewController animated:animated];
    //处理了push后隐藏底部UITabBar的情况，并解决了iPhonX上push时UITabBar上移的问题。
    CGRect rect = self.tabBarController.tabBar.frame;
    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    self.tabBarController.tabBar.frame = rect;
    
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
