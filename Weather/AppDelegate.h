//
//  AppDelegate.h
//  Weather
//
//  Created by xixixi on 15/10/9.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <MMDrawerController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong, nonatomic) NSDictionary *information;
//@property (strong,nonatomic)

@end

