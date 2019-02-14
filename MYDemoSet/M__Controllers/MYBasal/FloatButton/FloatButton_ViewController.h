//
//  FloatButton_ViewController.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/3/23.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "BaseViewController.h"

@interface FloatButton_ViewController : BaseViewController
/*
 https://www.jianshu.com/p/5a0ca7c4fd78
 
 背景介绍 ：在普通的iOS开发组中，一般测试机都不止一台，但是我们在开发的时候，不可能每台测试机时刻保持最新的代码，这就出现了一个问题，当测试测出问题的时候，(或者产品突然拿去点点看的时候出了问题)如果不知道当前的版本，可能不确定是什么时候出的问题。
 
 解决方案：如果当前环境是测试服的时候，展示一个全局浮动标签，这样不仅看到此标志就告诉测试(包括我们自己)当前的环境，当出现问题的时候，通过标签，可以快速定位当前问题发生的版本号等等
 
 思路：
 
 由于要全局显示，所以必须加在最上层（window层）
 由于需求图中有文字和背景图片，优先考虑UIButton（当然，如果有勇士非要用UIView，里面放imageView 和 label也ok）
 由于此图片不是半透明，会挡住后面的内容，所以这个标签必须可以拖动 - 考虑添加拖拽手势
 本质上可以理解为，创建一个UIButton，为其添加拖拽手势，然后将其添加到UIWindow显示
 
 
 
 */
@end
