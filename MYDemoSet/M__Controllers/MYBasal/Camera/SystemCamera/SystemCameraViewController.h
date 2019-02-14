//
//  SystemCameraViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/5/14.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"

@interface SystemCameraViewController : BaseViewController

#pragma mark 隐私
//NSCameraUsageDescription
/**
 1
 UIImagePickerController是iOS系统提供的和系统的相册和相机交互的一个类,可以用来获取相册的照片,也可以调用系统的相机拍摄照片或者视频。该类的继承结构是:
 
 UIImagePickerController-->UINavigationController-->UIViewController-->UIResponder-->NSObject

 由于该类继承自UINavgationController,所以在使用过程中一般实现UIImagePickerControllerDelegate和UINavigationControllerDelegate这两个代理，可以利用navgation的push 和pop操作自定义界面实现更复杂的交互效果。下面具体分析该类的一些方法和属性.

 */

/**
 2
 // UIAlertControllerStyleActionSheet的使用注意
 // 1.不能有文本框
 // 2.在iPad中,必须使用popover的形式展示
 
 // Text fields can only be added to an alert controller of style UIAlertControllerStyleAlert
 // 只能在UIAlertControllerStyleAlert样式的view上添加文本框
 
 */

/**
 3
 使用UIImagePickerController选取图片并访问原图
 https://www.jianshu.com/p/9828fff20896
 
 UIViewContentMode详解
 https://www.jianshu.com/p/8c784b59fe6a
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

@end
