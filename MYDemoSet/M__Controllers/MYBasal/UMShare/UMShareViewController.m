//
//  UMShareViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/6/26.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import "UMShareViewController.h"
//#import <UMShare/UMShare.h>
//#import <UMCommon/UMCommon.h>
#import <UShareUI/UShareUI.h>

//#import <UMCommonLog/UMCommonLogHeaders.h>
@interface UMShareViewController ()

@end

@implementation UMShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"友盟分享";
 
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击屏幕");
    [self getUMShareRelevantMethods];
    
}

-(void)getUMShareRelevantMethods{
    // 设置预定义平台(即:需要分享至哪些平台就将其枚举值中的参数添加进数组中)
    NSArray *sharePlatforms = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)];
    [UMSocialUIManager setPreDefinePlatforms:sharePlatforms];

    
    __weak typeof (self) weakSelf = self;
    // 显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [weakSelf shareWebPageToPlatformType:platformType AndCurrentViewController:nil];
   
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType AndCurrentViewController:(UIViewController *)controller{
    
    
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    //    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:@"https://sec.tiancity.com/homepage/server/mobilesecurity/secappad.jpg"];
    //https://mobile.umeng.com/images/pic/home/social/img-1.png
    //https://sec.tiancity.com/homepage/server/mobilesecurity/secappad.jpg
//    [shareObject setShareImage:[UIImage imageNamed:@"coordinate"]];
   
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        
        if (error) {
            NSLog(@"调用分享接口Error：************Share fail with error *********\nError:%@", error);
        }else {
            NSLog(@"调用分享接口：************UMShare************\nResponse data is:%@", result);
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = result;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                NSLog(@"response data is %@",result);
            }
            
        }
        
        // Callback
    }];
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
