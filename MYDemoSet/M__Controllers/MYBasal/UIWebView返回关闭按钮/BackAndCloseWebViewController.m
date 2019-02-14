//
//  BackAndCloseWebViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/1/23.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//https://www.jianshu.com/p/fa070e790647

#import "BackAndCloseWebViewController.h"

@interface BackAndCloseWebViewController ()<UIWebViewDelegate, NSURLConnectionDelegate>
@property (nonatomic, strong) UIWebView *webView;

//返回按钮
@property (nonatomic, strong) UIBarButtonItem *backItem;
//关闭按钮
@property (nonatomic, strong) UIBarButtonItem *closeItem;

//加载进度条
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, assign) BOOL isLoadFinished;

@end

@implementation BackAndCloseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    [self addLeftButtons];
    
    //加载进度
    
}


/**
 添加WebView
 */
- (void)createUI {
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    //http://app.xindaowm.com/cn/app/dm/index.html
    //https://www.baidu.com
    NSString *url = [NSString stringWithFormat:@"%@",@"http://app.xindaowm.com/cn/app/dm/index.html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

/**
 添加左按钮，包括箭头<、返回按钮、关闭按钮
 */
- (void)addLeftButtons{
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"leftback_btn"] forState:UIControlStateNormal];
    //让返回按钮内容继续向左边偏移15，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
    backButton.imageEdgeInsets =UIEdgeInsetsMake(0, -15,0, 0);
    [backButton addTarget:self action:@selector(backButAction) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    //返回Item
    self.backItem = [[UIBarButtonItem alloc]init];
    self.backItem.customView = backButton;

    //关闭Item
    self.closeItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction)];
    [_closeItem setTintColor:[UIColor blackColor]];

}

- (void)addProgressView{
    CGFloat progressH = 0.5f;
    CGRect naviBounds = self.navigationController.navigationBar.bounds;
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, naviBounds.size.height - progressH, naviBounds.size.width, progressH)];
    //背景色
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    //进度色
    self.progressView.progressTintColor = [UIColor blueColor];
    [self.navigationController.navigationBar addSubview:self.progressView];
    
}

/**
 返回按钮点击方法实现
 */
- (void)backButAction{
    //判断当前页面的上一级页面是否是WebView
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        //添加close按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.closeItem];
    }else{
        [self closeWebView];
    }
}

/**
 关闭按钮点击方法实现
 */
- (void)closeItemAction{
    [self closeWebView];
}

/**
 关闭WebView，返回到原生界面
 */
- (void)closeWebView{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

/**
 return NO 表示不处理该请求；

 @param webView <#webView description#>
 @param request <#request description#>
 @param navigationType <#navigationType description#>
 @return <#return value description#>
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    
    return YES;
}


/**
 开始加载页面

 @param webView webView description
 */
-(void)webViewDidStartLoad:(UIWebView *)webView{
    self.progressView.progress = 0;
    
}

/**
 页面加载完成

 @param webView webView description
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取当前网页的title
     self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.progressView.hidden = YES;
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
