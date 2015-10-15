//
//  weatherCell.m
//  Weather
//
//  Created by xixixi on 15/10/15.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "weatherCell.h"
#import "AppDelegate.h"
#import "Config.h"

//宏定义宽和高
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@implementation weatherCell
{
    AppDelegate *_app;
}


- (void)awakeFromNib {
    
    _app = [UIApplication sharedApplication].delegate;
    
    //设置位置
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 3 * 2);
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width / 4;
    self.view1.frame = CGRectMake(0, 0, width, height);
    self.view2.frame = CGRectMake(width, 0, width, height);
    self.view3.frame = CGRectMake(width * 2, 0, width, height);
    self.view4.frame = CGRectMake(width * 3, 0, width, height);
    
    self.contentView.layer.borderWidth = 0.25;
    self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view1.layer.borderWidth = 0.25;
    self.view1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view2.layer.borderWidth = 0.25;
    self.view2.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view3.layer.borderWidth = 0.25;
    self.view3.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view4.layer.borderWidth = 0.25;
    self.view4.layer.borderColor = [UIColor whiteColor].CGColor;
    self.lineView.frame = CGRectMake(0, 30, SCREEN_WIDTH, 0.25);
    self.lineView.backgroundColor = [UIColor whiteColor];
    
    self.viewArray = @[self.view1,self.view2,self.view3,self.view4];
    
    //设置view的内容
    [self setViewContent];
    
}

- (void)setViewContent
{
    NSDictionary *info = _app.information;
    NSArray *data = [[info objectForKey:@"results"][0] objectForKey:@"weather_data"];
    for (int i = 0; i <= 3; i ++) {
        NSDictionary *needData = data[i];
        UILabel *label1 = (UILabel *)[self.viewArray[i] viewWithTag:1];
        UILabel *label2 = (UILabel *)[self.viewArray[i] viewWithTag:2];
        UIImageView *iv1 = (UIImageView *)[self.viewArray[i] viewWithTag:3];
        UIImageView *iv2 = (UIImageView *)[self.viewArray[i] viewWithTag:4];
        UILabel *label3 = (UILabel *)[self.viewArray[i] viewWithTag:5];
        UILabel *label4 = (UILabel *)[self.viewArray[i] viewWithTag:6];
        UILabel *label5 = (UILabel *)[self.viewArray[i] viewWithTag:7];
        
        //设置信息
        label1.text = [[needData valueForKey:@"date"] substringWithRange:NSMakeRange(0, 2)];
        label2.text = [needData valueForKey:@"weather"];
        NSURL *url1 = [NSURL URLWithString:[needData valueForKey:@"dayPictureUrl"]];
        [iv1 sd_setImageWithURL:url1];
        NSURL *url2 = [NSURL URLWithString:[needData valueForKey:@"nightPictureUrl"]];
        [iv2 sd_setImageWithURL:url2];
        label5.text = [[needData valueForKey:@"temperature"] substringWithRange:NSMakeRange(0, 2)];
        label3.text = [[needData valueForKey:@"temperature"] substringWithRange:NSMakeRange(5, 2)];
        label4.text = label2.text;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
