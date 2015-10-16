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

@interface LeftViewController ()

@end

@implementation LeftViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //取得系统存储的用户添加的城市列表和空气果站点列表
    //code
    

    //暂时先各定义一个数据
    self.cityArray = [NSMutableArray arrayWithArray:@[@"淮北"]];
    self.ariArray = [NSMutableArray arrayWithArray:@[@"墨迹天气云区"]];
    
    
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    //表格重载
    [self.tableView reloadData];
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
