//
//  SystemCameraViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/14.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "SystemCameraViewController.h"
#import <Photos/Photos.h>

#import <AssetsLibrary/AssetsLibrary.h>

@interface SystemCameraViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UILabel *tapLabel;
@property (nonatomic, strong) UIImageView *tapImageView;

@property (nonatomic, strong) UIImagePickerController *pickVC;
@end

@implementation SystemCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"系统相机";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    
}
-(void)createUI{
    //UILabel
    self.tapLabel = [[UILabel alloc]init];
    _tapLabel.text = @"点击屏幕调用系统相机";
    _tapLabel.font = [UIFont systemFontOfSize:14];
    [_tapLabel sizeToFit];
    [self.view addSubview:_tapLabel];
    
    [_tapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //UIImageView
    self.tapImageView = [[UIImageView alloc]init];
    _tapImageView.userInteractionEnabled = YES;
    
    //图片占满整个父容器,并且不变形
    _tapImageView.contentMode = UIViewContentModeScaleAspectFill;
    _tapImageView.clipsToBounds = YES;
    
    [self.view addSubview:_tapImageView];
    
    [_tapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tapLabel.mas_bottom).offset(20);
        make.centerX.equalTo(_tapLabel.mas_centerX);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
    }];
    //手势
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.tapImageView addGestureRecognizer:tapGesture];
    
}

/**
 图片手势点击方法实现
 */
-(void)tapGestureAction:(UITapGestureRecognizer *)tap{
    
    /**
     创建一个UIActionSheet，其中destructiveButton会红色显示，可以用在一些重要的选项
     */
    //iOS8之后被弃用
    [self createAlertController_Sheet];
    
    //    [self createAlertController_alert];
    
    
}



/**
 创建alertSheet
 */
-(void)createAlertController_Sheet{
    if (@available(iOS 8.0, *)) {
        UIAlertController *alertSheetVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //        UIAlertAction *destroyAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //        }];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self startCamera];
        }];
        UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self startPhotoLibrary];
        }];
        UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        //        [alertSheetVC addAction:destroyAction];
        [alertSheetVC addAction:cameraAction];
        [alertSheetVC addAction:photoLibraryAction];
        [alertSheetVC addAction:videoAction];
        [alertSheetVC addAction:cancelAction];
        
        [self presentViewController:alertSheetVC animated:YES completion:nil];
        
    } else {
        // Fallback on earlier versions
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",@"视频", nil];
        [sheet showInView:self.view];
    }
    
}

/**
 创建alertView
 */
-(void)createAlertController_alert{
    if (@available(iOS 8.0, *)) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
        
        //        __weak typeof(alertVC) weakAlertVC = alertVC;
        
        //给AlertView添加一个输入框
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入账号";
            [textField addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingChanged];
        }];
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.secureTextEntry = YES;
            textField.placeholder = @"请输入密码";
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"action1默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action1];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"action2取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action2];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    } else {
        // Fallback on earlier versions
    }
    
    
    
}

- (void)usernameDidChange:(UITextField *)username{
    NSLog(@"你输入的用户名:%@", username.text);
}





#pragma mark - UIActionSheetDelegate
/**
 iOS8之前调用
 根据被点击的button做出反应,destructiveButtonTitle对应0,之后button依次排序
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //拍照
            [self startCamera];
            break;
        case 1:
            //从相册中选择
            [self startPhotoLibrary];
            break;
            
        default:
            break;
    }
}

/**
 拍照
 */
-(void)startCamera{
    NSLog(@"startCamera 拍照");
    //判断相机是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    self.pickVC = nil;
    //创建图片选择控制器
    self.pickVC = [[UIImagePickerController alloc]init];
    //设置打开照片相册类型
    _pickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    _pickVC.delegate = self;
    //是否允许拍照后进行裁剪,默认为NO,不允许裁剪
    _pickVC.allowsEditing = YES;
    
    [self presentViewController:_pickVC animated:YES completion:nil];
    
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
}

/**
 从相册中选择
 */
-(void)startPhotoLibrary{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    self.pickVC = nil;
    self.pickVC = [[UIImagePickerController alloc]init];
    
    _pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _pickVC.delegate = self;
    //是否允许选择照片后进行裁剪,默认NO,不允许裁剪
    _pickVC.allowsEditing = YES;
    
    //设置导航栏
    
    [self setNavi];
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self presentViewController:_pickVC animated:YES completion:^{
            
        }];
    }
    
}

/**
 视频
 */
-(void)startVideo{
    
}




/**
 调整导航栏上面控件的颜色
 */
-(void)setNavi{
    _pickVC.navigationBar.barTintColor = [UIColor blueColor];
    _pickVC.navigationBar.tintColor = [UIColor orangeColor];
    [_pickVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    _pickVC.navigationBar.translucent = NO;
}
#pragma mark -UIImagePickerControllerDelegate

/**
 适用获取所有媒体资源，只需判断资源类型(图片/视频)
 获取图片后的操作
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"didFinishPickingMediaWithInfo");
    
    //获取媒体类型
//    NSString *mdeiaTye = [info objectForKey:UIImagePickerControllerMediaType];
   
    //方法1:
    //销毁控制器
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //设置图片
        self.tapImageView.image = info[UIImagePickerControllerEditedImage];
    }];
    
    //方法2:重点:
    //通过info信息读取原始图片(*从相册中获取图片*)
//    [self getOriginImageWithALAssetsLibraryWithPickerVC:picker Info:info];
    
    
    //方法3:(*从相册中获取图片*)
//    [self getOriginImageWithPhotoKitWithPickerVC:picker Info:info];
    
    
    
    /**
     NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型
     NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     */
    
}



/**
 用ALAssetsLibrary读取原始图片数据
 
 其中UIImagePickerControllerMediaURL 是原始文件的URL,我们可以通过它来访问原始图片信息,这个URL不是沙盒文件路径的URL,而是一个AssetURL,需要系统提供的AssetsLibrary框架进行访问;
 
 ALAssetsLibrary可以实现查看相册列表,增加相册,保存图片到相册等功能.它的组成比较符合照片库本身的组成,照片库中的完整照片库对象,相册,相片都能在AssetsLibrary中找到一一对应的组成,这使得AssetsLibrary的使用变得直观而方便;
 */
-(void)getOriginImageWithALAssetsLibraryWithPickerVC:(UIImagePickerController *)picker Info:(NSDictionary<NSString *,id> *)info{
    
    NSURL *imageAssetUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
    //    if (!imageAssetUrl) {
    //        [picker dismissViewControllerAnimated:YES completion:^{
    //        }];
    //
    //        return;
    //    }
    
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:imageAssetUrl resultBlock:^(ALAsset *asset) {
        
        ALAssetRepresentation* representation = [asset defaultRepresentation];
        
        // 创建一个buffer保存图片数据
        
        uint8_t *buffer = (Byte*)malloc(representation.size);
        
        NSUInteger length = [representation getBytes:buffer fromOffset: 0.0  length:representation.size error:nil];
        
        NSLog(@"ALAssetsLibrary原图大小===>%lu M",(unsigned long)length/(1024*1024));
        
        // 将buffer转换为NSData object，然后释放buffer内存
        
        NSData *imageData = [[NSData alloc] initWithBytesNoCopy:buffer length:representation.size freeWhenDone:YES];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            //设置图片
            self.tapImageView.image = [UIImage imageWithData:imageData];
        }];
        
        
    } failureBlock:^(NSError *error) {
        
        //失败的处理
        
    }];
    
}
/**
 在iOS8以后，苹果提供一套全新的框架PhotoKit来代替ALAssetsLibrary。PhotoKit 是一套比 AssetsLibrary 更完整也更高效的库，对资源的处理跟 AssetsLibrary 也有很大的不同。
 
 下面再来看一下如何使用PhotoKit框架读取原始图片的数据
 PHImageRequestOptions中可以指定请求是同步或者异步。
 
 */

-(void)getOriginImageWithPhotoKitWithPickerVC:(UIImagePickerController *)picker Info:(NSDictionary<NSString *,id> *)info{
    NSURL *imageAssetUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    //    if (!imageAssetUrl) {
    //        [picker dismissViewControllerAnimated:YES completion:^{
    //            //设置图片
    //        }];
    //        return;
    //    }
    
    if (@available(iOS 8.0, *)) {
        PHFetchResult*result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetUrl] options:nil];
        PHAsset *asset = [result firstObject];
        PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
        
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:phImageRequestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            NSLog(@"PhotoKit原图大小===>%lu M",imageData.length/(1024*1024));
            [picker dismissViewControllerAnimated:YES completion:^{
                //设置图片
                self.tapImageView.image = [UIImage imageWithData:imageData];
            }];
            
        }];
        
    } else {
        // Fallback on earlier versions
    }
}



/**
 取消
 */
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
