//
//  TabBarViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/1/18.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationViewController.h"

#import "MainTypeViewController.h"
#import "MyFindTypeViewController.h"
#import "MySetTypeViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewControllers];
}
/**
 添加子控制器
 */
- (void)addChildViewControllers{
    [self addChildrenViewController:[[MainTypeViewController alloc]init] andTitle:@"主页" andImageName:@"tab_mine" andSelectImage:@"tab_mine_pre"];
    [self addChildrenViewController:[[MyFindTypeViewController alloc]init] andTitle:@"发现" andImageName:@"tab_mine" andSelectImage:@"tab_mine_pre"];
    [self addChildrenViewController:[[MySetTypeViewController alloc]init] andTitle:@"设置" andImageName:@"tab_mine" andSelectImage:@"tab_mine_pre"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    childVC.tabBarItem.selectedImage =  [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.title = title;
    
    //可以自定义navi
    NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:childVC];
    [self addChildViewController:navi];
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
