//
//  weatherCell.h
//  Weather
//
//  Created by xixixi on 15/10/15.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weatherCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *lineView;

@property (strong, nonatomic) IBOutlet UIView *view1;

@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) NSArray *viewArray;
@end
