//
//  CoreLocationObject.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2020/12/3.
//  Copyright © 2020 pengjiaxin. All rights reserved.
//

#import "CoreLocationObject.h"

#import <CoreLocation/CoreLocation.h>

@interface CoreLocationObject ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation CoreLocationObject
//引入CoreLocation.framework

+ (instancetype)sharedInstance{
    static CoreLocationObject *object = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [[CoreLocationObject alloc]init];
    });
    return object;
}

//初始化
- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        _locationManager.distanceFilter = 1000.0;
        _locationManager.delegate = self;
        
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

-(void)startWithCompletionHandler:(LocationCompletionBlock)block{
    self.completionBlock = block;
    
//    _locationAge = 0;
    [_locationManager startUpdatingLocation];
}


#pragma mark - CLLocationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [_locationManager stopUpdatingLocation];//结束定位
    
//    if (_locationAge != 0) return;
    
    //反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //将字典转为模型
        NSDictionary *dic = [self getInfoWithPlacemark:placemarks[0]];
        LocationModel *model = [[LocationModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        //位置数据处理
        [self locateCompleted:model];
    }];
    
//    _locationAge ++;
}
//位置数据处理
- (void)locateCompleted:(LocationModel *)location {
   
    if (_completionBlock) {
        _completionBlock(location);
    }
//    self.completionBlock = nil;//定位成功后销毁（避免产生保留环）
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"错误：拒绝定位");
    }else if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"错误：无法获取定位");
    }else {
        NSLog(@"%@",error.localizedDescription);
    }
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status ==kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
    }else if(status ==kCLAuthorizationStatusAuthorizedAlways||
             status ==kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"授权成功");

        [self.locationManager startUpdatingLocation];
    }else{
        NSLog(@"授权失败");
    }
}

#pragma mark - 整理位置信息
- (NSDictionary *)getInfoWithPlacemark:(CLPlacemark *)placemark {
    
    // 经纬度
    CLLocationCoordinate2D coordinate = placemark.location.coordinate;
    NSString *longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    // 省/市/县(区)/街道/详细地址
    NSString *province = placemark.administrativeArea;
    NSString *city = placemark.locality;
    province = province ? province : placemark.locality;//若省不存在则为直辖市
    NSString *subCity = placemark.subLocality;
    NSString *street = placemark.addressDictionary[@"Street"];
    
    NSString *address;
    if ([province isEqualToString:city]) {
        address = [NSString stringWithFormat:@"%@%@%@",city,subCity,street];
    }else {
        address = [NSString stringWithFormat:@"%@%@%@%@",province,city,subCity,street];
    }
    
    NSDictionary *dic = @{@"longitude":longitude,
                          @"latitude" :latitude,
                          @"province" :province,
                          @"city"     :city,
                          @"subCity"  :subCity,
                          @"street"   :street,
                          @"address"  :address};
    return dic;
}

@end






#pragma mark - 定位数据模型
@implementation LocationModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}






@end
