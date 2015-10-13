//
//  WeatherViewController.m
//  Weather
//
//  Created by xixixi on 15/10/14.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
//定义私有属性接口
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) CGFloat screenHeight;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
