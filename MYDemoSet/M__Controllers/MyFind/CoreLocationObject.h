//
//  CoreLocationObject.h
//  MYDemoSet
//
//  Created by pengjiaxin on 2020/12/3.
//  Copyright © 2020 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  LocationModel;
//block
typedef void(^LocationCompletionBlock)(LocationModel * _Nullable model);

//typedef void (^ReturnTextBlock)(NSString * _Nullable showText);


NS_ASSUME_NONNULL_BEGIN

@interface CoreLocationObject : NSObject

@property (nonatomic, copy) LocationCompletionBlock completionBlock;

//单利
+(instancetype)sharedInstance;

- (void)startWithCompletionHandler:(LocationCompletionBlock)block;



 
 
//@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
//
//- (void)returnText:(ReturnTextBlock)block;



@end


#pragma mark - 位置数据模型
@interface LocationModel : NSObject

@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *subCity;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *address;




@end

NS_ASSUME_NONNULL_END
