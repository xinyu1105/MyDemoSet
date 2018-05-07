//
//  TypeTableViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/23.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "TypeTableViewController.h"

#import "ExampleViewController.h"


@interface TypeTableViewController ()
@property (nonatomic, strong) NSMutableArray *typeTitlesArray;
@property (nonatomic, strong) NSMutableArray *vcClassNameArray;

@end

@implementation TypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的Demo集";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
                             nil];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld, %@",indexPath.row +1,self.typeTitlesArray[indexPath.row]];
    
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
