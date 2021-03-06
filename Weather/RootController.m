//
//  RootController.m
//  Weather
//
//  Created by xixixi on 15/10/16.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "RootController.h"
#import "Config.h"
#import "SearchCityVC.h"

@interface RootController ()

@end

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置左视图和中间视图
    self.tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];

    self.centerViewController = self.tabBarVC;
    self.leftDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftNavVC"];
    
    //注意使用方法和RESideMenu的区分------------------
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll]; //必须
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll]; // 必须
    self.maximumLeftDrawerWidth = 250;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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
