//
//  WeatherViewController.h
//  Weather
//
//  Created by xixixi on 15/10/14.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <MJRefresh.h>
#import "BaseTableViewController.h"

@interface WeatherViewController : BaseTableViewController <UICollectionViewDelegate, UICollectionViewDelegate,UIScrollViewDelegate>

- (void)loadNewData;

@end
