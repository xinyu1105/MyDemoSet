//
//  BaiduSimpleViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/10.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaiduSimpleMapViewController.h"
@interface BaiduSimpleMapViewController ()

@end

@implementation BaiduSimpleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //普通写法(开发中通常写法)：测试
    
    //地图显示
    BMKMapView * mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    
    
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
