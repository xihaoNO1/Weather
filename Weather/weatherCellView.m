//
//  weatherCellView.m
//  Weather
//
//  Created by xixixi on 15/10/19.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "weatherCellView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
#import "Config.h"

@implementation weatherCellView
{
    AppDelegate *_app;
    NSArray *viewArray;
    CGFloat width;
    CGFloat height;
}


//宏定义宽和高
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

- (id)getCell
{
    _app = [UIApplication sharedApplication].delegate;
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 3 * 2);
    //获取self的宽和高
    width = self.frame.size.width / 4;
    height = self.frame.size.height;
    
    //创建5个view
    UIView *view1  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UIView *view2  = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    UIView *view3  = [[UIView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
    UIView *view4  = [[UIView alloc] initWithFrame:CGRectMake(width * 3, 0, width, height)];
   
    
    self.contentView.layer.borderWidth = 0.25;
    self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    view1.layer.borderWidth = 0.25;
    view1.layer.borderColor = [UIColor whiteColor].CGColor;
    view2.layer.borderWidth = 0.25;
    view2.layer.borderColor = [UIColor whiteColor].CGColor;
    view3.layer.borderWidth = 0.25;
    view3.layer.borderColor = [UIColor whiteColor].CGColor;
    view4.layer.borderWidth = 0.25;
    view4.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, SCREEN_WIDTH , 0.3)];
    lineView.backgroundColor = [UIColor whiteColor];

    
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    [self addSubview:view4];
    [self addSubview:lineView];
    
    viewArray = @[view1,view2,view3,view4];
    
    //设置view的内容
    [self setViewContent];
    
    return self;
}

- (void)setViewContent
{
    NSDictionary *info = _app.information;
    NSArray *data = [[info objectForKey:@"results"][0] objectForKey:@"weather_data"];
    for (int i = 0; i <= 3; i ++) {
        NSDictionary *needData = data[i];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake( width/2 - 20, 10, 40, 30)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor whiteColor];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake( width/2 - 30, 60, 60, 30)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont systemFontOfSize:14];
        
        UIImageView *iv1 = [[UIImageView alloc] initWithFrame:CGRectMake( width/2 - 16 , 100, 32, 20)];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake( width/2 - 30, 130, 60, 30)];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = [UIColor whiteColor];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake( width/2 - 25, height - 95, 50, 30)];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.textColor = [UIColor whiteColor];
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake( width/2 - 16 , height - 60, 32, 20)];
        
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake( width/2 - 30, height - 30, 60, 30)];
        label5.textAlignment = NSTextAlignmentCenter;
        label5.textColor = [UIColor whiteColor];
        label5.font = [UIFont systemFontOfSize:14];
        //设置信息
        label1.text = [[needData valueForKey:@"date"] substringWithRange:NSMakeRange(0, 2)];
        label2.text = [needData valueForKey:@"weather"];
        NSURL *url1 = [NSURL URLWithString:[needData valueForKey:@"dayPictureUrl"]];
        [iv1 sd_setImageWithURL:url1];
        label3.text = [[needData valueForKey:@"temperature"] substringWithRange:NSMakeRange(0, 2)];
        label4.text = [[needData valueForKey:@"temperature"] substringWithRange:NSMakeRange(5, 2)];
        NSURL *url2 = [NSURL URLWithString:[needData valueForKey:@"nightPictureUrl"]];
        [iv2 sd_setImageWithURL:url2];
        label5.text = label2.text;
    
        //添加到对应的view
        [viewArray[i] addSubview:label1];
        [viewArray[i] addSubview:label2];
        [viewArray[i] addSubview:label3];
        [viewArray[i] addSubview:label4];
        [viewArray[i] addSubview:label5];
        [viewArray[i] addSubview:iv1];
        [viewArray[i] addSubview:iv2];
        
        
        
    }
}


@end
