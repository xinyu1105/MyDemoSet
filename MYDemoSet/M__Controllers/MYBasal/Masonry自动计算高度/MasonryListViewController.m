//
//  MasonryTableListViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/13.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "MasonryListViewController.h"
#import "MasonryListTableViewcell.h"
@interface MasonryListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *detailArrays;
@end

@implementation MasonryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Masonry约束实现自动布局";
    
    self.detailArrays= [NSMutableArray arrayWithObjects:
                        @"生",
                        @"活",
                        @"如",
                        @"此",
                        @"美",
                        @"好",
                        @"生活如此美好，再也不用计算高度了^.^ ",
                        @"生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ ",
                        @"生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ ",
                        @"生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ ",
                        @"生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ ",
                        @"生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ ",
                        @"生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ ",
                        @"生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^ 生活如此美好，再也不用计算高度了^.^  ",nil];
    
    self.tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
#pragma mark 3关键点设置估算高度
    _tableView.estimatedRowHeight = 20;
    [self.view addSubview:_tableView];
    
#pragma mark 2关键点
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
}

#pragma  mark  - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArrays.count;
}
#pragma mark 4关键点
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * testCellIdent = @"test_cell";
    MasonryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testCellIdent];
    if (!cell) {
        cell = [[MasonryListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testCellIdent];
    }
    NSString *title = [NSString stringWithFormat:@"row : %ld -- section : %ld",indexPath.row,indexPath.section];
    NSString *detail = self.detailArrays[indexPath.row] ;
    
    [cell configureCellWithTitle:title DetailText:detail];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中状态
    //不加此句时,在二级界面点击返回时,此行会由选中状态慢慢变成非选中状态
    //加上这句,返回时直接就是非选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
