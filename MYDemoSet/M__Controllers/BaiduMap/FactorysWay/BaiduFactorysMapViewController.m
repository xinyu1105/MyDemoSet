//
//  BaiduFactorysMapViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/2.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaiduFactorysMapViewController.h"
#import "BaiduMapFactorys.h"

#import "BaiduMapLocation.h"
@interface BaiduFactorysMapViewController ()

@end

@implementation BaiduFactorysMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //地图
    id<IMapViewFactorys> mapFactorys = [[BaiduMapFactorys alloc]init];
    id<IMapViewProtocol> mapView = [mapFactorys getMapView:self.view.bounds];
    [self.view addSubview:[mapView getView]];

    //定位
    id<IMapLocation> mapLocation = [mapFactorys getMapLocation];
    [mapLocation start];
    [mapLocation stop];
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
