//
//  CustomCameraViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/6/28.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface CustomCameraViewController : BaseViewController

//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession* session;
//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong) AVCaptureDeviceInput* deviceInput;
//照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;
//预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;








@end
