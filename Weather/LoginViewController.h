//
//  LoginViewController.h
//  Weather
//
//  Created by xixixi on 15/10/21.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginBn;
- (IBAction)clickLoginButton:(id)sender;
- (IBAction)clickRegisterButton:(id)sender;
- (IBAction)clickFindPasswordButton:(id)sender;

@end
