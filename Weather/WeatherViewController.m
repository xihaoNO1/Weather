//
//  WeatherViewController.m
//  Weather
//
//  Created by xixixi on 15/10/14.
//  Copyright © 2015年 xihao. All rights reserved.
//
#import <SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "AppDelegate.h"
#import "WeatherViewController.h"
#import "Config.h"
#import "weatherCell.h"
#import "zhishuCell.h"
#import "SearchCityVC.h"


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

//定义当前显示的城市
@property (nonatomic, strong)NSString *currentCity;
@end

@implementation WeatherViewController
{
    AppDelegate *_app;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _app = [UIApplication sharedApplication].delegate;

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
    
    //将状态栏字体改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"weather interface will appear");
    //获取系统中当前城市名
    self.currentCity = [Config getCurrentCityName];
    if (!self.currentCity) {
        SearchCityVC *searchCity = [[SearchCityVC alloc] init];
        [self presentViewController:searchCity animated:YES completion:nil];
    }
    else
    {
    //初始化天气信息
    [self freshWeatherData];
    [self.tableView reloadData];
    }
}

- (void)setHeadViewData
{
    NSDictionary *information =  _app.information;
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
    //使用SDWebImage缓存
    UIImageView *imageIV = (UIImageView *)[self.headSubView_1 viewWithTag:3];
    
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
    NSString *pm25Str_2 = [@"PM2.5 " stringByAppendingString:pm25Str];
    [self.pm25Bn setTitle:pm25Str_2 forState:UIControlStateNormal];
    self.pm25Bn.layer.cornerRadius = 10;
    self.pm25Bn.layer.masksToBounds = YES;
    self.pm25Bn.backgroundColor = [UIColor orangeColor];
    self.pm25Bn.alpha = 0.8;
}

//刷新天气信息
- (void)freshWeatherData
{
    
    //用字典封装参数
    NSDictionary *pramas = @{@"location":self.currentCity,
                             @"output":@"json",
                             @"ak":@"PHStmR8HLSAi9GLhbdizAr2V",
                             @"mcode":@"xi.Weather"};
    [_app.manager GET:@"http://api.map.baidu.com/telematics/v3/weather"
           parameters:pramas
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  //将返回信息保存到系统中
                  NSDictionary *info = (NSDictionary *)responseObject;
                  _app.information = info;
                 
                  //必须再次执行此代码 (为什么)
                  [self setHeadViewData];
                  
              } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  NSLog(@"%@",error);
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
        CGFloat alpha = 1 - offset.y / 100  - 0.64 ;
        [self.cartoonGirl setAlpha:alpha];
    }
}

#pragma mark - tabelDelegate and dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
        view1.backgroundColor = [UIColor blackColor];
        view1.alpha = 0.5;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 22)];
        label1.text = @" 预报";
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.font = [UIFont systemFontOfSize:15];
        label1.textColor = [UIColor whiteColor];
        [view1 addSubview:label1];

        
        return view1;
    }
    else
    {
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
        view2.backgroundColor = [UIColor blackColor];
        view2.alpha = 0.5;
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 22)];
        label2.text = @" 指数";
        label2.backgroundColor = [UIColor clearColor];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = [UIColor whiteColor];
        [view2 addSubview:label2];


        
        return view2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    if (section == 0) {
        return SCREEN_HEIGHT / 3 *2;
    }
    else
    {
        return SCREEN_HEIGHT / 4 * 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取当前分区号
    NSUInteger sectionNO = indexPath.section;
  
    if (sectionNO == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"weatherCell" owner:self options:nil];
        cell = nib[0];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [UITableViewCell new];
        zhishuCell *cellZhishu = [[zhishuCell alloc] init];
        UITableViewCell *getCell = (UITableViewCell *)[cellZhishu getCell];
        cell = getCell;
        return cell;
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"weather interface did appear");

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"weather interface  wil disappear");

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"weather interface did disappear");

}
@end
