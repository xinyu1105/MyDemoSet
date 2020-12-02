//
//  CMPedometerViewController.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2019/5/28.
//  Copyright © 2019年 pengjiaxin. All rights reserved.
//

#import "CMPedometerViewController.h"

#import <CoreMotion/CoreMotion.h>
@interface CMPedometerViewController ()

@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property(nonatomic,strong) CMPedometer *stepter;

@end

@implementation CMPedometerViewController

-(void)createUI{
    
    self.stepLabel = [[UILabel alloc]init];
    _stepLabel.textColor = [UIColor blackColor];
    _stepLabel.font = [UIFont systemFontOfSize:25];
    _stepLabel.frame = CGRectMake(100, 200, 200, 50);
    _stepLabel.text = [NSString stringWithFormat:@"步数：%@",@"0步"];;
    _stepLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_stepLabel];
    
    self.totalLabel = [[UILabel alloc]init];
    _totalLabel.textColor = [UIColor blackColor];
    _totalLabel.font = [UIFont systemFontOfSize:25];
    _totalLabel.frame = CGRectMake(100, 300, 200, 50);
    _totalLabel.text = [NSString stringWithFormat:@"距离：%@",@"0米"];;
    _totalLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_totalLabel];
}

-(NSDate *)zeroOfDate
{
//
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
//
//    components.hour = 0;
//
//     components.minute = 0;
//
//    components.second = 0;
//
//      // components.nanosecond = 0 not available in iOS
//
//    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
//
//    NSDate * date = [NSDate dateWithTimeIntervalSince1970:ts];
//
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//
//     NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//
//     return localeDate;
    
       NSCalendar *calendar = [NSCalendar currentCalendar];
    
        NSDate *currentDate = [NSDate date];
    
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
        NSDate *zeroDate = [calendar dateFromComponents:components];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: zeroDate];
    NSDate *localeDate = [zeroDate  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

//返回当天00:00
-(NSDate *)obtainTodayDate{
    return [NSDate date];
}
//返回现在的时间
-(NSDate *)obtainNextTodayDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    
    return startDate;
}

//获取当前时区的时间
-(NSDate *)getEndTime{
    //转换成本地时区
    NSDate *date = [NSDate date];
    NSTimeZone *zone = NSTimeZone.systemTimeZone;
    NSTimeInterval interval = [zone secondsFromGMTForDate:date];
    NSDate *nowDate = [date dateByAddingTimeInterval:interval];
    return nowDate;
}
//获取开始时间 当天0时0分0秒
-(NSDate *)getStartTime{
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    //当天的时间
    NSString *stringdate = [df stringFromDate:[self getEndTime]];
    NSDate *tDate = [df dateFromString:stringdate];
    //获取本地时区的当天0时0分0秒
    NSTimeZone *zone = NSTimeZone.systemTimeZone;
    NSTimeInterval interval = [zone secondsFromGMTForDate:tDate];
    NSDate *nowday = [tDate dateByAddingTimeInterval:(double)(interval)];
    return nowday;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
//    NSLog(@"当前时区的时间(当前时间)--->%@",[self getEndTime]);
//    NSLog(@"开始时间(当天0时0分0秒)--->%@",[self getEndTime]);
    
    NSLog(@"开始时间(当天0时0分0秒)--->%@",[self zeroOfDate]);

    
    if(![CMPedometer isStepCountingAvailable])
    {
        NSLog(@"计步器不可用");
        return;
    }
    
    if (@available(iOS 8.0, *)) {
        _stepter =[[CMPedometer alloc]init];
    } else {
        // Fallback on earlier versions
    }

    
    
    [_stepter startPedometerUpdatesFromDate:[self zeroOfDate] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        
        if(error){
            NSLog(@"error ==%@",error);
        }else{
            NSNumber *steps =pedometerData.numberOfSteps;
            NSNumber *distance =pedometerData.distance;
            
            NSDictionary *dic =@{
                                 @"steps":steps,
                                 @"distance":distance
                                 };
            
            NSLog(@"过去一天你一共走了%@步,一共%@米",steps,distance);
            //在后台线程结束之后，回到主线程刷新界面
            [self performSelectorOnMainThread:@selector(refreshUI:) withObject:dic waitUntilDone:NO];
           //回调主线程刷新
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self refreshUI:dic];
//            });
            
            
        }
        
    }];
    
    
}


-(void)refreshUI:(NSDictionary *)dic{
    NSNumber *distance =dic[@"distance"];
    float meters =[distance floatValue];
    
    self.stepLabel.text =[NSString stringWithFormat:@"步数：%@",dic[@"steps"]];
    self.totalLabel.text =[NSString stringWithFormat:@"距离：%.2f",meters];
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
