//
//  VerificationCodeView.m
//  MYDemoSet
//
//  Created by pengjiaxin on 2021/3/12.
//  Copyright © 2021 pengjiaxin. All rights reserved.
//

#import "VerificationCodeView.h"
#import "AESCrypt.h"
//#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define UIColorWithRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//iPhone宽适配
#define WSXFrom8(x) ([[UIScreen mainScreen] bounds].size.width / 375.0 * (x))
//间距15
#define margin (WSXFrom8(15))
//背景框
#define backW (WSXFrom8(350))
#define backH (WSXFrom8(300))
#define backX (([UIScreen mainScreen].bounds.size.width - backW)/2.0)
#define backY (([UIScreen mainScreen].bounds.size.height - backH)/2.0)
//背景图片 320*160
#define bgW (backW - 2 * margin)
#define bgH (bgW / 2.0)
//缺失图片60*160
#define slW (bgW * 3 / 16)
#define slH (slW)
//转化成320*160尺寸下的位置
#define WXTo320_160(x) (320 * (x) / bgW)

@interface VerificationCodeView()
/** /弹框背景 */
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *refreshButton;
/** 背景图片 */
@property (nonatomic, strong) UIImageView *bgImageView;
/** 缺少滑动图片 */
@property (nonatomic, strong) UIImageView *sliderImageView;
/** 滑动条 */
@property (nonatomic, strong) TCSlider *slider;

@property (nonatomic, strong) NSDictionary *dataDic;

/** 滑动点集合  eg 1,1611195566040|20,1611195566090 */
@property (nonatomic, copy) NSString *moveXSet;
@property (nonatomic, copy) NSString *lastTime;
@property (nonatomic, assign) CGFloat lastX;


@end

@implementation VerificationCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setBgImageUrl:(NSString *)bgImageUrl{
    _bgImageUrl = bgImageUrl;
    UIImage *image = [self stringToImage:bgImageUrl];
    [_bgImageView setImage:image];
}

- (void)setSliderImageUrl:(NSString *)sliderImageUrl{
    _sliderImageUrl = sliderImageUrl;
    UIImage *image = [self stringToImage:sliderImageUrl];
    [_sliderImageView setImage:image];
}

// 64base字符串转图片
- (UIImage *)stringToImage:(NSString *)str {
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData ];
    return photo;
}



/**
 显示验证码弹框
 */
-(void)showCodeView{
    //请求接口获取图片
    
    [self getDataWithCategary:@"default" siteId:@"2"];
    [self createUI];
    /*
     //792c61f6e2b641d6836abd3259b9b646
     //792c61f6e2b641d6
     //836abd3259b9b646
     
     NSString *key16 = @"792c61f6e2b641d6";
     NSString *key32 = @"792c61f6e2b641d5836abd3259b9b646";
     NSString *str = @"{\"Token\":\"e8896f6b65484e74912a77622aeddf2e\",\"MoveX\":\"228\",\"Action\":\"0,1618905920484|39,1618905920701|170,1618905920918|170,1618905920918|170,1618905920918|170,1618905920918|170,1618905920918|170,1618905920918|170,1618905920918|170,1618905920918|170,1618905920918|200,1618905921119|211,1618905921335|225,1618905921536|228,1618905921803\"}";
     
     
     NSString * encryStr = [AESCrypt encryptString:str key:key32];
     
     NSString * encryStr1 = [AESCrypt AES128Encrypt1:str key32:key32];
     NSString * decryptStr1 = [AESCrypt AES128Decrypt1:encryStr1 key32:key32];
     NSLog(@"str:%@  L:%lu",str,str.length);
     NSLog(@"encryStr:%@  L:%lu",encryStr,(unsigned long)encryStr.length);
     NSLog(@"encryStr1:%@ L:%lu",encryStr1,(unsigned long)encryStr1.length);
     
     NSLog(@"decryptStr1:%@",decryptStr1);
     
     */
}

/**
 显示验证码弹框
 */
-(void)removeCodeView{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

/**
 显示验证码界面
 */
-(void)showVerificationCodeViewWithViewType:(ViewType)viewType{
    
}

-(void)createUI{
    //模糊背景
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.bounds;
    visualEffectView.alpha = 0.7;
    [self addSubview:visualEffectView];
    
    //弹框背景
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(backX, backY, backW, backH)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    //文字
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请完成安全验证";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor darkGrayColor];
    [titleLabel sizeToFit];
    [self.backView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(margin);
        make.top.equalTo(self.backView.mas_top).offset(margin);
    }];
    
    //背景图片 320 *160
    self.bgImageView = [[UIImageView alloc]init];
    _bgImageView.backgroundColor = [UIColor lightGrayColor];
    [self.backView addSubview:_bgImageView];
    
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.top.equalTo(titleLabel.mas_bottom).offset(margin);
        make.width.equalTo(@bgW);
        make.height.equalTo(@bgH);
    }];
    
    //滑块图片 60*160
    self.sliderImageView = [[UIImageView alloc]init];
    //    _sliderImageView.backgroundColor = [UIColor redColor];
    [self.backView addSubview:_sliderImageView];
    
    [_sliderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_left);
        make.height.equalTo(self.bgImageView.mas_height);
        make.centerY.equalTo(self.bgImageView.mas_centerY);
        make.width.equalTo(@(slW));
    }];
    
    //刷新按钮
    self.refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_refreshButton addTarget:self action:@selector(refreshButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_refreshButton setImage:[UIImage imageNamed:@"slrefreshInage"] forState:UIControlStateNormal];
    [self.backView addSubview:_refreshButton];
    
    [_refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_right);
        make.top.equalTo(self.bgImageView.mas_top);
        make.width.height.equalTo(@WSXFrom8(30));
    }];
    

    
    //滑竿
    self.slider = [TCSlider new];
    // 属性配置
    // minimumValue  : 当值可以改变时，滑块可以滑动到最小位置的值，默认为0.0
    _slider.minimumValue = margin;
    // maximumValue : 当值可以改变时，滑块可以滑动到最大位置的值，默认为1.0
    _slider.maximumValue = bgW - slW + margin;
#pragma mark 注意 minimumTrackTintColor  setMinimumTrackImage不能同时设置
    
    //设置滑块左边（小于部分）线条的颜色
    //_slider.minimumTrackTintColor = UIColorWithRGBValue(0x1991fa);
    //设置滑块右边（大于部分）线条的颜色
    //_slider.maximumTrackTintColor = UIColorWithRGBValue(0xe4e7eb);
    
    [_slider setThumbImage:[UIImage imageNamed:@"slImage"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"slImagehight"] forState:UIControlStateHighlighted];
    
    [_slider setMinimumTrackImage:[UIImage imageNamed:@"slminbg"] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[UIImage imageNamed:@"slmaxbg"] forState:UIControlStateNormal];
    
    [_slider addTarget:self action:@selector(sliderAction:forEvent:) forControlEvents:UIControlEventValueChanged];
    //UIControlEventAllTouchEvents
    [self.backView addSubview:_slider];
    
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_left);
        make.width.equalTo(self.bgImageView.mas_width);
        make.top.equalTo(self.bgImageView.mas_bottom).offset((backH-CGRectGetHeight(titleLabel.frame)-2*margin-bgH-slH)/2);
    }];
    
    //添加到window
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
}


/**
 刷新按钮点击方法实现：获取新的背景及滑动图片，更换背景及滑动图片
 */
-(void)refreshButtonAction{
    //设置图片旋转
    /*
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [self.refreshButton.imageView.layer addAnimation:rotationAnimation forKey:@"refreshRotationAnimation"];
    */
    //请求接口获取图片
    [self getDataWithCategary:@"default" siteId:@"2"];
    [self setSliderDefaultValue];
    
    NSLog(@"bgW:%f bgH:%f slW:%f slH:%f",bgW,bgH,slW,slH);
}

/**
 设置默认的滑动
 */
- (void)setSliderDefaultValue{
    self.slider.value = 0.00;
    [self changeSliderWithVlue:self.slider.value];
}

/**
 slider滑动方法实现
 */
-(void)sliderAction:(UISlider *)slider forEvent:(UIEvent *)event{
    
    UITouchPhase phase = event.allTouches.anyObject.phase;
    
    if (phase == UITouchPhaseBegan) {
        //触摸开始
        //self.pointSet = [NSString string];
        self.lastTime = [self getDateTimeToMilliSeconds:[NSDate date]];
        self.lastX = 0;
        
        self.moveXSet = [NSString stringWithFormat:@"%@,%@",@"0",self.lastTime];
        NSLog(@"触摸开始");
    }else if(phase == UITouchPhaseEnded){
        //触摸结束
        
        //验证是否正确
        
        NSString *cValue = [NSString stringWithFormat:@"%.0f",WXTo320_160(slider.value - margin)];
        
        [self checkWithToken:self.dataDic[@"Data"][@"Token"] Key:self.dataDic[@"Data"][@"Key"] MoveX:cValue];
        
        //设置初始值
        NSLog(@"触摸结束");
        
        
    }else if (phase == UITouchPhaseMoved){
        NSLog(@"接触点移动");
        [self staticsMoveXWithSliderValue:slider.value];
        [self changeSliderWithVlue:slider.value];
    }
}
/**
 改变Slider的value
 */
-(void)changeSliderWithVlue:(CGFloat)value{
    CGRect rect = self.sliderImageView.frame;
    rect.origin.x = value;
    self.sliderImageView.frame = rect;
}
/**
 统计MoveX
 */
-(void)AstaticsMoveXWithSliderValue:(CGFloat)value{
    
    
    //统计pointSet
    NSString *cTime = [self getDateTimeToMilliSeconds:[NSDate date]];
    if ([cTime integerValue] - [self.lastTime integerValue] >200) {
        self.lastTime = cTime;
        
        NSString *cValue = [NSString stringWithFormat:@"%.0f",WXTo320_160(value - margin)];
        
        NSString *cPonit = [NSString stringWithFormat:@"%@,%@",cValue,cTime];
        self.moveXSet = [self.moveXSet stringByAppendingFormat:@"|%@",cPonit];
    }

    NSLog(@"%@",self.moveXSet);
    
}

-(void)staticsMoveXWithSliderValue:(CGFloat)value{
    NSArray *a = [self.moveXSet componentsSeparatedByString:@"|"];
    NSLog(@"%@",a);
    if (a.count >60) {
        return;
    }
    //统计pointSet
    NSString *cTime = [self getDateTimeToMilliSeconds:[NSDate date]];
    
    CGFloat cX = WXTo320_160(value - margin);
     
    if (fabs(cX - self.lastX) >8) {
        self.lastX = cX;

        NSString *cValue = [NSString stringWithFormat:@"%.0f",cX];
        
        NSString *cPonit = [NSString stringWithFormat:@"%@,%@",cValue,cTime];
        self.moveXSet = [self.moveXSet stringByAppendingFormat:@"|%@",cPonit];
    }

    NSLog(@"%@",self.moveXSet);
    
}

/**
 获取bg和Slider图片
 */
-(void)getDataWithCategary:(NSString *)cg siteId:(NSString *)si{
    NSString * ts = [self getDateTimeToMilliSeconds:[NSDate date]];
    NSString *urlStr = [NSString stringWithFormat:@"https://nc.tiancity.com/captcha/get?Category=%@&SiteId=%@&ts=%@",cg,si,ts];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                return;
            }
    
            //NSLog(@"%@",self.dataDic);
            NSLog(@"Token:%@",self.dataDic[@"Data"][@"Token"]);
            NSLog(@"Key:%@",self.dataDic[@"Data"][@"Key"]);
            
            if ([self.dataDic[@"Data"][@"Token"] length]) {
                [self showWithData:self.dataDic[@"Data"]];
            }
        });
    }];
    
    [task resume];
    
}
-(void)get{

     NSString *urlstring=@"http://japi.juhe.cn/joke/content/list.from?key=488c65f3230c0280757b50686d1f1cd5&page=1&pagesize=1&sort=asc&time=1418745237";
     //如果URL网址里有中文，要先转成utf8
     NSString *urlstr=[urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    //设置请求地址,GET请求，直接把请求参数跟在URL的后面以？隔开，多个参数之间以&符号拼接
    NSURL *url=[NSURL URLWithString:LIST_URL];
   
    //1.创建Session
    NSURLSession *session=[NSURLSession sharedSession];
    //2.根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //在子线程中执行的
        NSLog(@"----%@----",[NSThread currentThread]);
        if(error==nil){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dict);
        }
        
        [dispatch_async(dispatch_get_main_queue(), ^{
            //UI的操作
        })];
        
        //回归主线程，如果要做UI的操作，必须回到主线程
        //[self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:(BOOL)];
        // [dispatch_async(dispatch_get_main_queue(), <#^(void)block#>)]
        //[NSOperationQueue mainQueue] addOperationWithBlock:<#^(void)block#>
    }];
    //3.启动任务
    [dataTask resume];
}



-(void)showWithData:(NSDictionary *)dict{
    self.bgImageUrl = dict[@"Bg"];
    self.sliderImageUrl = dict[@"Slider"];
}

//时间戳
//将NSDate类型的时间转换为时间戳,从1970/1/1开始

-(NSString *)getDateTimeToMilliSeconds:(NSDate *)datetime{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    //毫秒
    long long totalMilliseconds = interval*1000 ;
    NSString *str = [NSString stringWithFormat:@"%lld",totalMilliseconds];
    return str;
}
/**
 客户端验证，验证滑块滑动位置是否正确
 */
-(void)checkWithToken:(NSString *)token Key:(NSString *)key MoveX:(NSString *)moveX{
    if (token.length == 0 || key.length == 0) {
        return;
    }
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://nc.tiancity.com/captcha/check"]];
    // 2.创建一个网络请求，分别设置请求方法、请求参数
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSMutableString *actToken = [NSMutableString stringWithString:@"{"];
    [actToken appendFormat:@"\"%@\":\"%@\",",@"Token",token];
    [actToken appendFormat:@"\"%@\":\"%@\",",@"MoveX",moveX];
    [actToken appendFormat:@"\"%@\":\"%@\"",@"Action",self.moveXSet];
    [actToken appendString:@"}"];
    
    NSString *actCrypt = [AESCrypt encryptString:actToken key:key];
    NSString *actEncode = [self URLEncodeWithString:actCrypt];
    
    NSString *args = [NSString stringWithFormat:@"Token=%@&AcToken=%@",token,actEncode];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        
        //回归主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                return;
            }
            
            [self checkResult:dict];

        });
    }];
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}

/**
 验证结果处理
 */
-(void)checkResult:(NSDictionary *)dict{
    if ([dict[@"Data"][@"Result"] intValue]) {
        // 验证成功
        NSLog(@"验证成功");
        NSLog(@"Token：%@\nValidate：%@",dict[@"Data"][@"Token"],dict[@"Data"][@"Validate"]);

        [self showSuccessView];
        
        //移除行为验证码弹框
         [self removeCodeView];
    }else{
        // 验证失败->刷新重试
        NSLog(@"验证失败");
        
        [self showFailView];
        [self.layer addAnimation:failAnimal() forKey:@"failAnimal"];
        [self getDataWithCategary:@"default" siteId:@"2"];
        [self setSliderDefaultValue];
        
    }
}


//失败动画
static inline CABasicAnimation *failAnimal(){
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setDuration:0.1];
    animation.fromValue = @(-M_1_PI/16);
    animation.toValue = @(M_1_PI/16);
    animation.repeatCount = 2;
    animation.autoreverses = YES;
    return animation;
}

-(void)showSuccessView{
    UIImageView *successView = [[UIImageView alloc] initWithFrame:self.bgImageView.frame];
    [successView setImage:[UIImage imageNamed:@"slsuccess"]];
    [self.backView addSubview:successView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bgImageView.bounds.size.height-30, self.bgImageView.bounds.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"验证成功";
    label.textColor = [UIColor whiteColor];
    [successView addSubview:label];
    
    //移除successView
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [successView removeFromSuperview];
    });
    
    
}
-(void)showFailView{
    UIImageView *failView = [[UIImageView alloc] initWithFrame:self.bgImageView.frame];
    [failView setImage:[UIImage imageNamed:@"slfail"]];
    [self.backView addSubview:failView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bgImageView.bounds.size.height-30, self.bgImageView.bounds.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"验证失败请重试";
    label.textColor = [UIColor whiteColor];
    [failView addSubview:label];
    
    //移除failView
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [failView removeFromSuperview];
    });
}


#pragma mark --------------URLEncode/URLDecode--------------
/**
 URLEncode
 */
- (NSString *)URLEncodeWithString:(NSString *)string{
    //deprecated in iOS 9.0
    /*
     NSString *result =
     CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
     (CFStringRef)string,
     NULL,
     CFSTR("!*'();:@&;=+$,/?%#[] "),
     kCFStringEncodingUTF8));
     return [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     */
    
    NSString *charactersToEscape = @"!*'();:@&;=+$,/?%#[] ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

/**
 URLDecode
 */
- (NSString *)URLDecodeWithString:(NSString *)string{
    //deprecated in iOS 9.0
    /*
     NSMutableString *outputStr = [NSMutableString stringWithString:string];
     
     [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
     
     return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     */
    //deprecated in iOS 9.0
    /*
     NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
     (__bridge CFStringRef)self,
     CFSTR(""),
     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
     return decodedString;
     
     */
    return [string stringByRemovingPercentEncoding];
}














@end


@implementation TCSlider
/**
 改变滑动条高度
 */
- (CGRect)trackRectForBounds:(CGRect)bounds{
    CGRect result = [super trackRectForBounds:bounds];
    // result.size.height = 15;
    result.size.height = slW;
    result.origin.y = (CGRectGetHeight(bounds)-CGRectGetHeight(result))/2;
    return result;
}




@end




