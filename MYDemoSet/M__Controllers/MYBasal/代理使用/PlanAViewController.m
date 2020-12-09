//
//  PlanAViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/8/24.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "PlanAViewController.h"
#import "PlanBViewController.h"
@interface PlanAViewController ()<sendStringDelegate>
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation PlanAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"A界面";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, SCREEN_WIDTH - 40, 40)];
    label.text = @"从A界面 push 到B界面 ;返回A界面时, 把B界面字符串 name 传递到A界面显示";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:label];
    
    self.nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 20)];
    [self.view addSubview:_nameLabel];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    PlanBViewController* another=[[PlanBViewController alloc] init];
    //指定代理
    another.delegate=self;
    [self.navigationController pushViewController:another animated:YES];
    
}


/**
 调用代理方法:
 第一个界面接收第二个界面传递过来的值，是通过以下的代理方法来实现的
 
 也就是在第二个界面中远程调用该方法，
 警记：此时的self.valueLabel是不为nil的，因为在进入第二个界面之前，我们已经完成了对第一个界面的初始化了，所以此时self.valueLabel是存在的。
 
 如果调用远程方法时，远程方法体中用到的控件还没有初始化，值为nil。

 @param nameStr nameStr description
 */
-(void)sendName:(NSString *)nameStr{
    self.nameLabel.text = nameStr;
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
