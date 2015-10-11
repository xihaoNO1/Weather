//
//  TabBarController.m
//  Weather
//
//  Created by xixixi on 15/10/10.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8;
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.translucent = YES;
    
    //创建tabBar item
    //初始化5个tabBarItem用于替换系统tabBar的item
    UITabBarItem *item1 = self.tabBar.items[0];
    UITabBarItem *item2 = self.tabBar.items[1];
    UITabBarItem *item3 = self.tabBar.items[2];
    //定义按钮1
    item1.tag = 1;
    [item1 setTitle:@"天气"];
    [item1 setImage:[UIImage imageNamed:@"weather-clear@2x.png"]];
    [item1 setSelectedImage:[UIImage imageNamed:@"weather-clear@2x.png"]];
    //创建按钮2
    item2.tag = 2;
    [item2 setTitle:@"时景"];
    [item2 setImage:[UIImage imageNamed:@"shijing@2x.png"]];
    [item2 setSelectedImage:[UIImage imageNamed:@"shijing@2x.png"]];
    //创建按钮3
    item3.tag = 3;
    [item3 setTitle:@"我"];
    [item3 setImage:[UIImage imageNamed:@"wo@2x.png"]];
    [item3 setSelectedImage:[UIImage imageNamed:@"wo@2x.png"]];


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
