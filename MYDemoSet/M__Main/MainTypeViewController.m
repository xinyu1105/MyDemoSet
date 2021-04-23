//
//  MainTypeViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/23.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "MainTypeViewController.h"

#import "MainTypeTableViewCell.h"

#import "ExampleViewController.h"


@interface MainTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *typeTitlesArray;
@property (nonatomic, strong) NSMutableArray *vcClassNameArray;

@end

@implementation MainTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    self.typeTitlesArray = [NSMutableArray arrayWithObjects:
                            @"测试Example",
                            @"浮动按钮",
                            @"空白页展示",
                            @"BaiduSimpleMap",
                            @"GaodeSimpleMap",
                            @"BaiduProtocolMap",
                            @"GaodeProtocolMap",
                            @"BaiduFactoryMap",
                            @"GaodeFactoryMap",
                            @"BaiduFactorysMap(地图,定位)",
                            @"SystemCamera",
                            @"CustomCamera",
                            @"Masonry(TableView自动计算高度)",
                            @"delegate传值（A->B界面间传值）",
                            @"登录delegate",
                            @"JS调用原生OC（通过UIWebView拦截URL）",
                            @"UIWebView 左上角添加返回 关闭按钮 （返回上一级）",
                            @"WKWebViewController",
                            @"CMPedometerViewController计步器",
                            @"UMShareViewController分享",
                            @"CoreLocation定位",
                            nil];
    self.vcClassNameArray = [NSMutableArray arrayWithObjects:
                             @"ExampleViewController",
                             @"FloatButton_ViewController",
                             @"EaseBlankPageViewController",
                             @"BaiduSimpleMapViewController",
                             @"GaodeSimpleMapViewController",
                             @"BaiduProtocolMapViewController",
                             @"GaodeProtocolMapViewController",
                             @"BaiduFactoryMapViewController",
                             @"GaodeFactoryMapViewController",
                             @"BaiduFactorysMapViewController",
                             @"SystemCameraViewController",
                             @"CustomMainViewController",
                             @"MasonryListViewController",
                             @"PlanAViewController",
                             @"LoginDelegateViewController",
                             @"JSCallOCInterceptURLViewController",
                             @"BackAndCloseViewController",
                             @"WKWebViewController",
                             @"CMPedometerViewController",
                             @"UMShareViewController",
                             @"CoreLocationViewController",
                             nil];
    
    self.tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, StatusAndNaviHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(StatusAndNaviHeight + TabbarHeight));
    NSLog(@"%lf %lf", StatusHeight,StatusAndNaviHeight);
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 40;
    [self.view addSubview:_tableView];
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//
//        make.top.equalTo(self.view.mas_top).offset((StatusAndNaviHeight));
//        make.bottom.equalTo(self.view.mas_bottom).offset(-(iPhoneXSafeBottomMargin));
//    }];
    
    [self.tableView registerClass:[MainTypeTableViewCell class] forCellReuseIdentifier:@"cell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeTitlesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell configureCellWithTitle:[NSString stringWithFormat:@"%ld, %@",indexPath.row +1,self.typeTitlesArray[indexPath.row]]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class currentVC = NSClassFromString(self.vcClassNameArray[indexPath.row]);
    UIViewController *vc = [[currentVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
