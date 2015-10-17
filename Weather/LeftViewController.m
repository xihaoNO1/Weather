//
//  LeftViewController.m
//  Weather
//
//  Created by xixixi on 15/10/13.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "LeftViewController.h"
#import "Config.h"
#import "AppDelegate.h"
#import "SearchCityVC.h"

@interface LeftViewController ()

@end

@implementation LeftViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //取得系统存储的用户添加的城市列表和空气果站点列表
    
    //暂时先各定义一个数据
    self.cityArray = [NSMutableArray arrayWithArray:@[@"淮北"]];
    self.ariArray = [NSMutableArray arrayWithArray:@[@"墨迹天气云区"]];
    
    //存储城市和空气果列表信息
    [Config setCityList:self.cityArray];
    [Config setAriList:self.ariArray];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //将状态栏字体改为默认 (黑)
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    NSLog(@"leftView interface will appear");
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    [self.tableView reloadData];
}
- (IBAction)tapLeftButton:(id)sender {
    
    
}

- (IBAction)tapRightButton:(id)sender
{

    SearchCityVC *searchVC = [[SearchCityVC alloc] init];
    [self presentViewController:searchVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.cityArray.count;
    }
    else return self.ariArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        NSString * title = @"空气果";
        return title;
    }
    return @"城市";
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前行号
    NSInteger  section = indexPath.section ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"location"
                                                            forIndexPath:indexPath];

    AppDelegate *_app = [UIApplication sharedApplication].delegate;
    if (section == 0) {
        
        //获取行号
        NSInteger rowNO = indexPath.row;
        //获取天气信息
        NSDictionary *information =  _app.information;
        NSDictionary *currentInfo = [Config getCurrentInfo:information];
        NSString *tempe = [[currentInfo valueForKey:@"date"] substringWithRange:NSMakeRange(14, 2)];
        //设置天气信息
        cell.imageView.frame = CGRectMake(7, 7, 30, 30);
        cell.imageView.image = [UIImage imageNamed:@"leftIcon_1.png"];
        cell.textLabel.text = self.cityArray[rowNO];
        cell.detailTextLabel.text = [tempe stringByAppendingString:@"°C"];
        return cell;
    }
    else
    {
        //获取行号
        NSInteger rowNO = indexPath.row;
        
        cell.imageView.image = [UIImage imageNamed:@"leftIcon_2.png"];
        cell.textLabel.text = self.ariArray[rowNO];
        
        //因无数据反馈 暂时先使用固定数据
        cell.detailTextLabel.text = @"23°C";
        return cell;
    }
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"leftView interface did appear");
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //表格重载
    [self.tableView reloadData];
//    [self removeObserver:self forKeyPath:@"cityArray"];
    NSLog(@"leftView interface  wil disappear");
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //将状态栏字体改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    NSLog(@"leftView interface did disappear");
    
}


@end
