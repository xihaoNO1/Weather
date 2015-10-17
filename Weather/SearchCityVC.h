//
//  SearchCityVC.h
//  Weather
//
//  Created by xixixi on 15/10/17.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCityVC : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *ariView;

@end
