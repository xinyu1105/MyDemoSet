//
//  WKWebViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/1/29.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
API_AVAILABLE(ios(8.0))
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addWKWebView];
    [self addProgressView];
    
    
}

- (void)addWKWebView{
    // 创建WKWebView
    if (@available(iOS 8.0, *)) {
        self.wkWebView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    } else {
        // Fallback on earlier versions
    }
    _wkWebView.backgroundColor = [UIColor whiteColor];
    _wkWebView.navigationDelegate = self;
    
    // 设置访问的URL
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    // 根据URL创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // WKWebView加载请求
    [_wkWebView loadRequest:request];
    // 将WKWebView添加到视图
    [self.view addSubview:_wkWebView];
    //给WKWebView添加监听
    [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
}

- (void)addProgressView{
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 5);
    
    [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
    _progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:_progressView];
    
}
#pragma mark - WKNavigationDelegate


/**
 开始加载
 
 @param webView webView description
 @param navigation navigation description
 */
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation API_AVAILABLE(ios(8.0)){
    NSLog(@"页面开始加载时调用");
    //开始加载的时候，让进度条显示
    self.progressView.hidden = NO;
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation API_AVAILABLE(ios(8.0)){
    NSLog(@"didCommitNavigation");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation API_AVAILABLE(ios(8.0)){
    NSLog(@"didFinishNavigation");
}

#pragma mark - KVO
//kvo 监听进度

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress
                              animated:animated];
        
        if (self.wkWebView.estimatedProgress >= 1.0f) {
            
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    self.wkWebView.navigationDelegate = nil;
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
