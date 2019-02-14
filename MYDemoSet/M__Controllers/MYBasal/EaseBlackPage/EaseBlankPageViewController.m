//
//  EaseBlankPageViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/8.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "EaseBlankPageViewController.h"

@interface EaseBlankPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation EaseBlankPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"空白页展示";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
    
}

-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    self.datasource = [NSMutableArray array];
    
    __weak typeof(self)weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //加载服务端数据
        [weakSelf loadData];
        
    }];
    [_tableView.mj_header beginRefreshing];
}

-(void)loadData{
    //成功时
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
    
    __weak typeof(self)weakSelf = self;
    //无数据
//    [self.view configWityType:EaseBlankPageTypeTask hasData:self.datasource.count hasError:(self.datasource.count > 0) reloadButtonBlock:^(id sender) {
//        [weakSelf.tableView.mj_header beginRefreshing];
//    }];
    
    //error
    [self.view configWityType:EaseBlankPageTypeTask hasData:(self.datasource.count>0) hasError:YES reloadButtonBlock:^(id sender) {
        [weakSelf.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the cell...
    
    return cell;
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
