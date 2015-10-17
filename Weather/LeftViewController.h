//
//  LeftViewController.h
//  Weather
//
//  Created by xixixi on 15/10/13.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UITableViewController

@property (nonatomic, strong)NSMutableArray *cityArray; // 属性用userDefault存储
@property (nonatomic, strong)NSMutableArray *ariArray;  // 属性用userDefault存储 

@end
