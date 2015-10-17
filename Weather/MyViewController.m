//
//  MyViewController.m
//  Weather
//
//  Created by xixixi on 15/10/10.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "MyViewController.h"
#import "UIScrollView+ScalableCover.h"

@interface MyViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *portraitIV;

@end

@implementation MyViewController


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
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];

    [self setCoverImage];//使用类库添加可变图像
    self.portraitIV.bounds = CGRectMake(0, 0, 100, 100);
    self.portraitIV.image = [UIImage imageNamed:@"Snip20151013_1.png"];
    self.portraitIV.layer.cornerRadius = self.portraitIV.frame.size.width / 2;
    self.portraitIV.layer.masksToBounds = YES;
    self.portraitIV.alpha = 0.8;


}


- (void)setCoverImage
{
    NSString *imageName = @"myView_bg.png";
    
    if (!self.tableView.scalableCover) {
        [self.tableView addScalableCoverWithImage:[UIImage imageNamed:imageName]];
    } else {
        self.tableView.scalableCover.image = [UIImage imageNamed:imageName];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"%f",offset.y);
    if (offset.y < -64.0) {
        CGFloat alpha = 0.8 + offset.y / 100 + 0.64;
        [self.portraitIV setAlpha:alpha];
    }
    else
    {
        [self.portraitIV setBounds:CGRectMake(0, 0, 100 - 4 * offset.y / 6.4  - 40, 100 - 4 * offset.y / 6.4  - 40)];
        self.portraitIV.layer.cornerRadius = self.portraitIV.frame.size.width / 2;
    }
    
}



@end
