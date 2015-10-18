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
   
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    [self.tableView reloadData];
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
//删除时的提示信息
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

// UITableViewDataSource协议中定义的方法。该方法的返回值决定某行是否可编辑
- (BOOL) tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

// UITableViewDelegate协议中定义的方法。该方法的返回值决定单元格的编辑状态
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView
            editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}

// UITableViewDataSource协议中定义的方法。移动完成时激发该方法
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:
(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)
destinationIndexPath
{
    NSInteger sourceRowNo = [sourceIndexPath row];
    NSInteger destRowNo = [destinationIndexPath row];
    // 获取将要移动的数据
    id targetObj = self.cityArray[sourceRowNo];
    // 从底层数组中删除指定的数据项
    [self.cityArray removeObjectAtIndex: sourceRowNo];
    // 将移动的数据项插入到指定位置
    [self.cityArray insertObject:targetObj atIndex:destRowNo];
}

// UITableViewDataSource协议中定义的方法
// 编辑（包括删除或插入）完成时激发该方法
- (void) tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle
	forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果正在提交删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger rowNo = [indexPath row];
        
        //如果删除的是currentCity
        if ([self.cityArray[rowNo] isEqualToString:[Config getCurrentCityName]]) {
            [Config setCurrentCityName:self.cityArray[0]];
        }
        
        // 从底层NSArray集合中删除指定的数据项
        [self.cityArray removeObjectAtIndex:rowNo];
        
      
        // 从UITableView的界面上删除指定的表格行
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        //全部删除时,跳转到添加界面
        if (self.cityArray.count == 0) {
            SearchCityVC *searchVC = [[SearchCityVC alloc] init];
            [self presentViewController:searchVC animated:YES completion:nil];
        }
    }
}
- (IBAction)tapEdit:(id)sender {
    //改变按钮文字
    if ([[sender title] isEqualToString:@"编辑"]) {
        self.navigationItem.leftBarButtonItem.title = @"完成";
    }
    else
    {
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
    // 使用动画切换表格的编辑状态
    [self.tableView setEditing: !self.tableView.editing animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //取得系统存储的用户添加的城市列表和空气果站点列表
    self.cityArray = [[Config getCityList] mutableCopy];
    self.ariArray = [NSMutableArray arrayWithArray:@[@"墨迹天气云区"]];
    
    if (self.cityArray.count == 0) {
        SearchCityVC *searchVC = [[SearchCityVC alloc] init];
        [self presentViewController:searchVC animated:YES completion:nil];
    }

    [self.tableView reloadData];
    //将状态栏字体改为默认 (黑)
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    NSLog(@"leftView interface will appear");
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"leftView interface did appear");
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //保存编辑后的表格数据,存储到系统cityList
    [Config setCityList:self.cityArray];
    [Config setAriList:self.ariArray];
    
    //正在编辑时,title为完成,此时切换界面,执行此方法 使界面不可编辑
    if (![self.navigationItem.leftBarButtonItem.title isEqualToString:@"编辑"]) {
        
        [self.tableView setEditing: !self.tableView.editing animated:NO];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
    
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
