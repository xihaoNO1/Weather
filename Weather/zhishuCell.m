//
//  zhishuCell.m
//  Weather
//
//  Created by xixixi on 15/10/15.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "zhishuCell.h"
#import "Config.h"
#import "AppDelegate.h"

//宏定义宽和高
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@implementation zhishuCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)getCell
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2);
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = self.frame.size.height;
    //创建6个子view
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width / 2, height / 3)];
    view1.backgroundColor = [UIColor clearColor];
    view1.layer.borderColor = [UIColor whiteColor].CGColor;
    view1.layer.borderWidth = 0.25;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width / 2, 0, width / 2, height / 3)];
    view2.backgroundColor = [UIColor clearColor];
    view2.layer.borderColor = [UIColor whiteColor].CGColor;
    view2.layer.borderWidth = 0.25;
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, height / 3, width / 2, height / 3)];
    view3.backgroundColor = [UIColor clearColor];
    view3.layer.borderColor = [UIColor whiteColor].CGColor;
    view3.layer.borderWidth = 0.25;
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(width / 2, height / 3, width / 2, height / 3)];
    view4.backgroundColor = [UIColor clearColor];
    view4.layer.borderColor = [UIColor whiteColor].CGColor;
    view4.layer.borderWidth = 0.25;
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, height/3 * 2, width / 2, height / 3)];
    view5.backgroundColor = [UIColor clearColor];
    view5.layer.borderColor = [UIColor whiteColor].CGColor;
    view5.layer.borderWidth = 0.25;
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(width / 2, height / 3 * 2, width / 2, height / 3)];
    view6.backgroundColor = [UIColor clearColor];
    view6.layer.borderColor = [UIColor whiteColor].CGColor;
    view6.layer.borderWidth = 0.25;
    
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    [self addSubview:view4];
    [self addSubview:view5];
    [self addSubview:view6];
    
    //获取所需指数生活数据
    NSArray *array = @[view1,view2,view3,view4,view5,view6];
    NSArray *zhishuInfo = [Config getCurrentLifeInfo:app.information];
    NSArray *imageArray = @[@"chuanyi.png",@"xiche.png",@"lvyou.png",@"ganmao.png",@"yundong.png",@"ziwaixian.png"];
    
    for (int i = 0 ; i <= 5; i++) {
        NSDictionary *needZhishu = zhishuInfo[i];
        UIImageView *imageIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArray[i]]];
        imageIv.frame = CGRectMake(10, 10, 45, 45);
        imageIv.layer.cornerRadius = 10;
        imageIv.layer.masksToBounds = YES;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 90, 40)];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = [needZhishu valueForKey:@"title"];
        label1.textAlignment = NSTextAlignmentRight;
        label1.textColor = [UIColor whiteColor];
    
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, 90, 55)];
        label2.backgroundColor = [UIColor clearColor];
        label2.text = [needZhishu valueForKey:@"des"];
        label2.textAlignment =NSTextAlignmentRight;
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont systemFontOfSize:11];
        label2.numberOfLines = 3;
        
        [array[i] addSubview:imageIv];
        [array[i] addSubview:label1];
        [array[i] addSubview:label2];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
