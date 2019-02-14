//
//  BaiduFactoryMapViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/2.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaiduFactoryMapViewController.h"
#import "BaiduMapFactory.h"
@interface BaiduFactoryMapViewController ()

@end

@implementation BaiduFactoryMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"百度工厂方法模式";
    
    id <IMapViewFactory> baiduFactory = [[BaiduMapFactory alloc]init];
    id <IMapViewProtocol> mapView = [baiduFactory getMapView:self.view.bounds];
    [self.view addSubview:[mapView getView]];
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
