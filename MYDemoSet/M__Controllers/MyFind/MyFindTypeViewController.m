//
//  MyFindTypeViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/3/11.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import "MyFindTypeViewController.h"
#import "MainTypeTableViewCell.h"
@interface MyFindTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *typeTitlesArray;
@property (nonatomic, strong) NSMutableArray *vcClassNameArray;
@end

@implementation MyFindTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.typeTitlesArray = [NSMutableArray arrayWithObjects:
                            @"图片验证码",nil];
    self.vcClassNameArray = [NSMutableArray arrayWithObjects:
                             @"ExampleViewController",nil];
    self.tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 40;
    [self.view addSubview:_tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeTitlesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    MainTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MainTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell configureCellWithTitle:[NSString stringWithFormat:@"%ld, %@",indexPath.row +1,self.typeTitlesArray[indexPath.row]]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class currentVC = NSClassFromString(self.vcClassNameArray[indexPath.row]);
    UIViewController *vc = [[currentVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
