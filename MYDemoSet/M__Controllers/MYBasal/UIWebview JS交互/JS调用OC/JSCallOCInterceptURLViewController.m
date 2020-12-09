//
//  JSCallOCInterceptURLViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/1/18.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import "JSCallOCInterceptURLViewController.h"

@interface JSCallOCInterceptURLViewController ()<UIWebViewDelegate>
/** webView */
@property(nonatomic, strong)UIWebView *webView;
@end

@implementation JSCallOCInterceptURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createUI];
}

- (void)createUI {

    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSCallOCInterceptURL" ofType:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * url = [request URL];
    
    if ([[url scheme] isEqualToString:@"firstclick"]) {
        // firstClick://shareClick?title=分享的标题&content=分享的内容&url=链接地址&imagePath=图片地址
        NSArray *params = [url.query componentsSeparatedByString:@"&"];
        
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        NSMutableString *strM = [NSMutableString string];
        for (NSString *paramStr in params) {
            NSArray *dictArray = [paramStr componentsSeparatedByString:@"="];
            if (dictArray.count > 1) {
                //值：title的内容
                NSString *decodeValue = [dictArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                decodeValue = [decodeValue stringByRemovingPercentEncoding];
                [tempDict setObject:decodeValue forKey:dictArray[0]];
                [strM appendString:decodeValue];
            }
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"这是OC原生的弹出窗" message:strM delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"tempDic:%@",tempDict);
        return NO;
    }
    return YES;
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
