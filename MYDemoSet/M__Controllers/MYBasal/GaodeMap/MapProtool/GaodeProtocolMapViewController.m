//
//  GaodeProtocolMapViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/11.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "GaodeProtocolMapViewController.h"
#import "GaodeMapView.h"
@interface GaodeProtocolMapViewController ()

@end

@implementation GaodeProtocolMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速实现高德地图";
    
    id<IMapViewProtocol> gaodeMapView = [[GaodeMapView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:[gaodeMapView getView]];
    
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
