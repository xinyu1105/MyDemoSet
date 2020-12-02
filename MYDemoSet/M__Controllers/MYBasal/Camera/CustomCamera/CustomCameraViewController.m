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

@property (nonatomic, strong) AVCaptureDevice *device;
/** 对焦的绿框 */
@property (nonatomic)UIView *focusView;
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
    //前置、后置摄像头切换
    [self createChangeCameraButton];
    
    [self addCustomDownView];
}

/**
 初始化所有对象
 */
-(void)initAVCaptureSession{
    self.session = [[AVCaptureSession alloc] init];
    NSError *error;
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [_device lockForConfiguration:nil];
    //设置闪光灯为自动
    if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
        NSLog(@"支持闪光灯");
        [_device setFlashMode:AVCaptureFlashModeAuto];
    }
    // 开启自动对焦
    if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
        [_device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
    }
    
    // 开启自动曝光
    if ([_device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
        [_device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
    }
    

//    //白平衡
//    if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
//        [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
//    }
 
    [_device unlockForConfiguration];
    
    self.deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.deviceInput]) {
        [self.session addInput:self.deviceInput];
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
    _focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _focusView.layer.borderWidth = 1.0;
    _focusView.layer.borderColor =[UIColor greenColor].CGColor;
    _focusView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_focusView];
    _focusView.hidden = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

/**
 添加切换摄像头按钮
 */
-(void)createChangeCameraButton{
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.frame = CGRectMake(0, 0, 40, 44);
    [changeButton setTitle:@"切换" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:changeButton];
    
}

/**
 切换摄像头按钮的点击方法的实现
 */
-(void)changeButtonAction{
    //获取摄像头的数量（该方法会返回当前能够输入视频的全部设备，包括前后摄像头和外接设备）
    NSInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    //摄像头的数量小于等于1的时候直接返回
    if (cameraCount <= 1) {
        return;
    }
    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    //获取当前相机的方向（前/后）
    AVCaptureDevicePosition position = [[self.deviceInput device] position];
    
    //切换摄像头给 previewLayer 加动画
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    
    
    if (position == AVCaptureDevicePositionFront) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
        animation.subtype = kCATransitionFromLeft;
    }else if (position == AVCaptureDevicePositionBack){
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        animation.subtype = kCATransitionFromRight;
    }
    [self.previewLayer addAnimation:animation forKey:nil];
    
    //输入流
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    if (newInput != nil) {
        [self.session beginConfiguration];
        //先移除原来的input
        [self.session removeInput:self.deviceInput];
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.deviceInput = newInput;
        }else{
            //如果不能加现在的input，就加原来的input
            [self.session addInput:self.deviceInput];
        }
        [self.session commitConfiguration];
    }
    
}

/**
 手势点击方法实现

 @param gesture <#gesture description#>
 */
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}


- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    
    if ([self.device lockForConfiguration:&error]) {
        //对焦模式和对焦点
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        //曝光模式和曝光点
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
         [self.device unlockForConfiguration];
        
        _focusView.center = point;
        _focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _focusView.hidden = YES;
            }];
        }];
        
    }
    
    
}



-(AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
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
