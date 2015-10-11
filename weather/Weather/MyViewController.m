//
//  MyViewController.m
//  Weather
//
//  Created by xixixi on 15/10/10.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

static CGFloat kImageOriginHight = 200;
static CGFloat kTempHeight = 80.0f;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏的背景图片为透明
    UIImage *image = [UIImage imageNamed:@"navi_bg.png"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    
    
    self.imageView.frame = CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight + kTempHeight);
    self.imageView.image = [UIImage imageNamed:@"myView_bg.png"];
    [self.tableView  addSubview:self.imageView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    NSLog(@"yOffset===%f",yOffset);
    CGFloat xOffset = (yOffset + kImageOriginHight)/2;
    if (yOffset < -kImageOriginHight) {
        CGRect f = self.imageView.frame;
        f.origin.y = yOffset - kTempHeight;
        f.size.height =  -yOffset + kTempHeight;
        f.origin.x = 0.0;
        f.size.width = 320 + fabsf(xOffset)*2;
        self.imageView.frame = f;
    }
}


@end
