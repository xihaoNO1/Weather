//
//  LoginViewController.m
//  Weather
//
//  Created by xixixi on 15/10/21.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "LoginViewController.h"
#import <UIViewController+MMDrawerController.h>

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //为底层view增加手势处理器,点击使文本框放弃第一响应
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer  alloc]
                                      initWithTarget:self
                                      action:@selector(tap:) ];
    [self.view addGestureRecognizer:tapGes];
    //设置登陆按钮外观
    self.loginBn.layer.cornerRadius = 10;
    self.loginBn.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击手势触发方法
- (void)tap:(UITapGestureRecognizer *)gesture
{
    [self.nameField  resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
}
- (IBAction)clickLoginButton:(id)sender;
{
}
- (IBAction)clickRegisterButton:(id)sender;
{
}
- (IBAction)clickFindPasswordButton:(id)sender
{
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    NSLog(@"登陆界面 将要出现");
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"登陆界面将要消失");
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
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
