//
//  WeatherViewController.m
//  Weather
//
//  Created by xixixi on 15/10/14.
//  Copyright © 2015年 xihao. All rights reserved.
//
#import <SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
#import "WeatherViewController.h"
#import "Config.h"


//宏定义宽和高
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@interface WeatherViewController ()
//定义私有属性接口
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *headSubView_1;
@property (strong, nonatomic) IBOutlet UIView *headSubview_2;
@property (strong, nonatomic) IBOutlet UIButton *windBn;
@property (strong, nonatomic) IBOutlet UIButton *temBn;

@property (strong, nonatomic) IBOutlet UIButton *weatherBn;
@property (strong, nonatomic) IBOutlet UIButton *pm25Bn;
@property (strong, nonatomic) IBOutlet UIImageView *cartoonGirl;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) CGFloat screenHeight;
@end

@implementation WeatherViewController
{
    AppDelegate *_app;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _app = [UIApplication sharedApplication].delegate;
    //初始化天气信息
    [self freshWeatherData];
    [NSThread sleepForTimeInterval:2];
    //设置导航栏的背景图片为透明
    UIImage *image = [UIImage imageNamed:@"navi_bg.png"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                      forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
        
    //设置背景图片的颜色
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIImage *background = [UIImage imageNamed:@"bg"];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    //为表视图设置背景
    self.tableView.backgroundView = self.backgroundImageView;
    
    self.headSubView_1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headSubView_1.layer.borderWidth = 0.25;
    self.headSubview_2.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headSubview_2.layer.borderWidth = 0.25;
    
    

}


- (void)setHeadViewData
{
    NSDictionary *information =  _app.information;
    NSLog(@"===========%@",information);
   
    //获取今天和明天的信息
    NSDictionary *currentInfo = [Config getCurrentInfo:information];
    NSDictionary *twoDayInfo = [Config getTwodayInfo:information];
    
    //设置headView的三个按钮----也可改成label+gesture
    [self.windBn setTitle:[currentInfo valueForKey:@"wind"] forState:UIControlStateNormal];
    [self.weatherBn setTitle:[currentInfo valueForKey:@"weather"] forState:UIControlStateNormal];
    NSString *tempe = [[currentInfo valueForKey:@"date"] substringWithRange:NSMakeRange(14, 2)];
    [self.temBn setTitle:[tempe stringByAppendingString:@"°"] forState:UIControlStateNormal];
    
    //设置headView_1
    NSString *taday = @"今天    ";
    NSString *taday_2 = [taday stringByAppendingString:[currentInfo valueForKey:@"temperature"]];
    UILabel *label_1 =(UILabel *) [self.headSubView_1 viewWithTag:1];
    [label_1 setText:taday_2];
    
    UILabel *label_2 = (UILabel *)[self.headSubView_1 viewWithTag:2];
    [label_2 setText:[currentInfo valueForKey:@"weather"]];
//
//    // 获取白天天气图标
//    NSString *dayPic = [currentInfo valueForKey:@"dayPictureUrl"];
//    //获取URL
//    NSURL *dayPicURL = [NSURL URLWithString:dayPic];
    //使用SDWebImage缓存
    UIImageView *imageIV = (UIImageView *)[self.headSubView_1 viewWithTag:3];
//    [imageIV sd_setImageWithURL:dayPicURL placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    
    //---------网络图太难看 只是用本地图
    imageIV.image = [UIImage imageNamed:@"weather-clear.png"];
    
    
    //设置headView_1
    NSString *tomorrow = @"明天    ";
    NSString *tomorrow_2 = [tomorrow stringByAppendingString:[twoDayInfo valueForKey:@"temperature"]];
    UILabel *label_21=(UILabel *) [self.headSubview_2 viewWithTag:1];
    [label_21 setText:tomorrow_2];
    
    UILabel *label_22 = (UILabel *)[self.headSubview_2 viewWithTag:2];
    [label_22 setText:[twoDayInfo valueForKey:@"weather"]];
//    // 获取白天天气图标
//    NSString *dayPic_2 = [twoDayInfo valueForKey:@"dayPictureUrl"];
//    //获取URL
//    NSURL *dayPicURL_2 = [NSURL URLWithString:dayPic_2];
    //使用SDWebImage缓存
    UIImageView *imageIV_2 = (UIImageView *)[self.headSubview_2 viewWithTag:3];
//    [imageIV_2 sd_setImageWithURL:dayPicURL_2 placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    //---------网络图太难看 只是用本地图
    imageIV_2.image = [UIImage imageNamed:@"weather-clear.png"];
    
    //设置PM2.5按钮
    NSString *pm25Str = [[_app.information objectForKey:@"results"][0] objectForKey:@"pm25"];
    NSString *pm25Str_2 = [@"PM2.5指数 " stringByAppendingString:pm25Str];
    [self.pm25Bn setTitle:pm25Str_2 forState:UIControlStateNormal];
}

//刷新天气信息
- (void)freshWeatherData
{
    
    //用字典封装参数
    NSDictionary *pramas = @{@"location":@"淮北",
                             @"output":@"json",
                             @"ak":@"PHStmR8HLSAi9GLhbdizAr2V",
                             @"mcode":@"xi.Weather"};
    [_app.manager GET:@"http://api.map.baidu.com/telematics/v3/weather"
           parameters:pramas
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  //将返回信息保存到系统中
                  NSDictionary *info = (NSDictionary *)responseObject;
                  _app.information = info;
                  [self setHeadViewData];
                  
              } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  NSLog(@"连接服务器出错");
              }];
}

//- (void)viewDidLayoutSubviews
//{
//    //设置表视图headView
//    self.headView.frame = CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT);
//    [self.headView viewWithTag:1].frame = CGRectMake(10, SCREEN_HEIGHT - 60 -80 - 49, 15, 15);
//    [self.headView viewWithTag:2].frame = CGRectMake(10, SCREEN_HEIGHT - 60  - 49, SCREEN_WIDTH / 3, 80);
//    
//    self.headSubView_1.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.headSubView_1.layer.borderWidth = 0.5;
//    self.headSubView_1.frame = CGRectMake(0, SCREEN_HEIGHT - 49 -60, SCREEN_WIDTH / 2, 60) ;
//    [self.headSubView_1 viewWithTag:1].frame = CGRectMake(20, 20, SCREEN_WIDTH/3, 40);
//    
//    self.headSubview_2.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.headSubview_2.layer.borderWidth = 0.5;
//    self.headSubview_2.frame = CGRectMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 60 - 49, SCREEN_WIDTH / 2, 60);
//    [self.headSubview_2 viewWithTag:1].frame = CGRectMake(20, 20, SCREEN_WIDTH / 3, 40);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"%f",offset.y);
    if (offset.y > -64.0) {
        CGFloat alpha = 1 - offset.y / 100 * 2 - 0.64 * 2;
        [self.cartoonGirl setAlpha:alpha];
    }
}



@end
