//
//  CustomCameraViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/6/28.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "CustomCameraViewController.h"

#import "CustomMainViewController.h"

@interface CustomCameraViewController ()
@property (nonatomic, strong) UIView *customDownView;
@property (nonatomic, strong) UIButton *photoButton;

@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImage *showImage;
@end

@implementation CustomCameraViewController

/**
 在viewWillAppear方法里开启session
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (self.session) {
        [self.session startRunning];
    }
}


/**
 在viewDidDisappear方法里关闭session
 */
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    
    if (self.session) {
        [self.session stopRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"拍照";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initAVCaptureSession];
    
    [self addCustomDownView];
}

/**
 初始化所有对象
 */
-(void)initAVCaptureSession{
    self.session = [[AVCaptureSession alloc] init];
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    //设置闪光灯为自动
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    
    self.previewLayer.frame = CGRectMake(10, 64 +10,SCREEN_WIDTH-20, SCREEN_HEIGHT - 200);
    
    
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.view.layer.masksToBounds = YES;
    [self.view.layer addSublayer:self.previewLayer];
    
    
    /*
     图片拉伸方式
     AVLayerVideoGravityResize, // 非均匀模式。两个维度完全填充至整个视图区域
     AVLayerVideoGravityResizeAspect,// 等比例填充，直到一个维度到达区域边界
     AVLayerVideoGravityResizeAspectFill,// 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
     */
}


-(void)addCustomDownView{
    
    self.customDownView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 116, SCREEN_WIDTH, 116)];
    _customDownView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_customDownView];
    
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setTitle:@"拍照" forState:UIControlStateNormal];
    [_photoButton addTarget:self action:@selector(photoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _photoButton.frame = CGRectMake((SCREEN_WIDTH - 50)/2.0, (126 - 50)/2.0, 50, 50);
    [_photoButton setBackgroundColor:[UIColor redColor]];
    [self.customDownView addSubview:_photoButton];
}

/**
 拍照按钮点击方法实现
 */
-(void)photoButtonAction{
    
    //进行拍照保存图片
    AVCaptureConnection *conntion = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        self.showImage = [UIImage imageWithData:imageData];
        
//        [self Dophoto];
        
        [self showImageWithImage:[UIImage imageWithData:imageData]];
        
    }];
    
}

-(void)showImageWithImage:(UIImage *)image{
    
    UIView *viewb = [[UIView alloc]init];
    viewb.frame = self.view.frame;
    viewb.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewb];
    
    
    UIImageView *imagev = [[UIImageView alloc] initWithImage:image];
    imagev.contentMode = UIViewContentModeScaleAspectFill;
    //超出容器范围的切除掉
    imagev.clipsToBounds = YES;
    
    imagev.backgroundColor = [UIColor lightGrayColor];
    imagev.frame = CGRectMake(10, 64 +10,SCREEN_WIDTH-20, SCREEN_HEIGHT - 200);
    [viewb addSubview:imagev];
    
    self.cancelButton = [[UIButton alloc]init];
    [_cancelButton setTitle:@"重拍" forState:UIControlStateNormal];
    [_cancelButton setTintColor:[UIColor whiteColor]];
    _cancelButton.frame = CGRectMake(30, SCREEN_HEIGHT-70, 60, 20);
    [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewb addSubview:_cancelButton];
    
    self.confirmButton = [[UIButton alloc]init];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton setTintColor:[UIColor whiteColor]];
    _confirmButton.frame = CGRectMake(SCREEN_WIDTH - 90, SCREEN_HEIGHT-70, 60, 20);
    [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewb addSubview:_confirmButton];
    
    
}

/**
 重拍按钮点击方法实现
 */
-(void)cancelButtonAction:(UIButton *)button{
    [button.superview removeFromSuperview];
}

/**
 确定按钮点击方法实现
 */
-(void)confirmButtonAction:(UIButton *)button{
    CustomMainViewController *mainVC ;
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[CustomMainViewController class]]) {
            
            mainVC = (CustomMainViewController *)vc;
            mainVC.tapImageView.image = self.showImage;
            [self.navigationController popToViewController:mainVC animated:YES];
        }
    }

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
