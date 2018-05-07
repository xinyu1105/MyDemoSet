//
//  UIView+EaseBlankPageView.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2018/4/4.
//  Copyright © 2018年 pengjiaxin. All rights reserved.
//

#import "UIView+EaseBlankPageView.h"
#import <objc/runtime.h>
static char BlankPageViewKey;
@implementation UIView (EaseBlankPageView)

- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (EaseBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}
/*
 一,主要函数:
 1, objc_setAssociatedObject:
 objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key,
 id _Nullable value, objc_AssociationPolicy policy)
 
 2, objc_getAssociatedObject:
 objc_getAssociatedObject(id _Nonnull object, const void * _Nonnull key)
 OBJC_AVAILABLE(10.6, 3.1, 9.0, 1.0, 2.0);
 
 3, objc_removeAssociatedObjects:
 objc_removeAssociatedObjects(id _Nonnull object)
 OBJC_AVAILABLE(10.6, 3.1, 9.0, 1.0, 2.0);
 
 二,基本说明:关联对象就是runTime界的NSMultableDictionary
 
 objc_setAssociatedObject 相当于 setValue:forKey 进行关联value对象
 
 objc_getAssociatedObject 用来读取对象
 
 objc_AssociationPolicy 属性 是设定该value在object内的属性,即 assgin, (retain,nonatomic)...等
 objc_removeAssociatedObjects 该函数来移除一个关联对象,或者使用 objc_setAssociatedObject 函数将key指定的关联对象设置为nil
 
 三,相关参数:
 key:要保证全局唯一,key与关联的对象是一一对应关系.
 value:要关联的对象
 policy:关联策略,有以下5种关联策略
 
 OBJC_ASSOCIATION_ASSIGN 等价于 @propetry(assign)
 OBJC_ASSOCIATION_RETAIN_NONATOMIC 等价于 @propetry(strong,nonatomic)
 OBJC_ASSOCIATION_COPY_NONATOMIC 等价于 @propetry(copy,nonatomic)
 OBJC_ASSOCIATION_RETAIN @propetry 等价于 (strong,atomic)
 OBJC_ASSOCIATION_COPY 等价于 @propetry(copy,atomic)
 四,使用场景
 关联对象相当于实例变量，在类别(也有人管叫分类)里面，不能创建实例变量， 关联对象就可以解决这种问题。
 
 */

-(void)configWityType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[EaseBlankPageView alloc]initWithFrame:self.bounds];
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPageView];
        [self.blankPageView configWityType:EaseBlankPageTypeTask hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
    
}
//注意：这边有对父视图加载时的判断，只有是表格视图才可以；这边有对背景视图的增加及删除的操作；
-(UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView * aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}


@end
