//
//  SwipableViewController.h
//  Weather
//
//  Created by xixixi on 15/10/11.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizonalTableViewController.h"
#import "TitleBarView.h"

@interface SwipableViewController : UIViewController

@property (nonatomic, strong) HorizonalTableViewController *viewPager;
@property (nonatomic, strong) TitleBarView *titleBar;

- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers;
- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers underTabbar:(BOOL)underTabbar;

- (void)scrollToViewAtIndex:(NSUInteger)index;
@end
