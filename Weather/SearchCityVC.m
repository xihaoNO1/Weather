//
//  SearchCityVC.m
//  Weather
//
//  Created by xixixi on 15/10/17.
//  Copyright © 2015年 xihao. All rights reserved.
//
#import <UIViewController+MMDrawerController.h>
#import "SearchCityVC.h"
#import "TabBarController.h"
#import "Config.h"
#import "SearchAriVC.h"
#import "CCLocation/CCLocationManager.h"


@implementation SearchCityVC
{
    UISearchBar * _searchBar;
    // 保存原始表格数据的NSArray对象
    NSArray * _tableData;
    // 保存搜索结果数据的NSArray对象
    NSArray* _searchData;
    BOOL _isSearch;
}


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isSearch = NO;
    
    //加载城市信息
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"City" withExtension:@"plist"];
    _tableData = [NSArray arrayWithContentsOfURL:url];
    
    
    //创建表视图
    self.tableView = [[UITableView alloc] initWithFrame:
                      CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 150 )
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //创建UISearchBar控件
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH - 40, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    _searchBar.layer.cornerRadius = 10;
    _searchBar.layer.masksToBounds = YES;
    
    //创建搜索控件背景view
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Search_backView.jpg"]];
    
    //创建模态视图返回按钮
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(tapBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    //创建backVIew的label
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, SCREEN_WIDTH - 20, 40)];
    textLabel.text = @"世界, 一个触碰的距离";
    textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    textLabel.textColor = [UIColor whiteColor];
        
    //创建底部ariView视图
    self.ariView = [[UIView alloc] initWithFrame:
                    CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.ariView.bounds];
    iv.image = [UIImage imageNamed:@"ariView_bg.png"];
    [self.ariView addSubview:iv];
    
    //为底部ariView创建手势
    UITapGestureRecognizer *tapAriView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAriViewCallback:)];
    [self.ariView addGestureRecognizer:tapAriView];
    
    
    [backView addSubview:_searchBar];
    [backView addSubview:back];
    [backView addSubview:textLabel];
    [self.view addSubview:backView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.ariView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)tapBackButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapAriViewCallback:(UITapGestureRecognizer *)gesture
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SearchAri" bundle:nil];
    SearchAriVC *searchAri = [storyBoard instantiateViewControllerWithIdentifier:@"SearchAri"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self presentViewController:searchAri animated:YES completion:nil];
}

#pragma mark -table
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // 如果处于搜索状态
    if(_isSearch)
    {
        // 使用_searchData作为表格显示的数据
        return _searchData.count;
    }
    else
    {
        // 否则使用原始的_tableData作为表格显示的数据
        return _tableData.count;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString* cellId = @"cellId";
    // 从可重用的表格行队列中获取表格行
    UITableViewCell* cell = [tableView
                             dequeueReusableCellWithIdentifier:cellId];
    // 如果表格行为nil
    if(!cell)
    {
        // 创建表格行
        cell = [[UITableViewCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    // 获取当前正在处理的表格行的行号
    NSInteger rowNo = indexPath.row;
    if (rowNo == 0 && !_isSearch) {
        cell.textLabel.text = _tableData[rowNo];
        
//        cell.imageView.image = [UIImage imageNamed:@"location_icon.png"];
        
        return cell;
    }
    cell.textLabel.text = _isSearch ? _searchData[rowNo] : _tableData[rowNo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取行
    NSInteger rowNO = indexPath.row;
    //定义城市名
    __block NSString *currentName = [NSString new];
    
    
    if (rowNO == 0) {
        
        [[CCLocationManager shareLocation]getCity:^(NSString *cityString) {
            currentName = [cityString substringToIndex:cityString.length - 1];
            
            NSLog(@"%@",currentName);
            
            //获取系统存储的城市列表,添加新城市,并存储到系统中
            NSMutableArray *cityArray = [[Config getCityList] mutableCopy];
            if (!cityArray) {
                NSMutableArray *cityFir = [[NSMutableArray alloc] initWithArray:@[currentName]];
                [Config setCityList:cityFir];
            }
            else
            {
                [cityArray addObject:currentName];
                [Config setCityList:cityArray];
            }
            //将当前选中城市设置为当前城市
            [Config setCurrentCityName:currentName];
            
            //跳转到weather界面
            [self dismissViewControllerAnimated:YES completion:nil];

        }];

    }
    else
    {
        
      //获取选中的行的城市名
      if (_isSearch) {
        currentName = _searchData[rowNO];
      }
      else
      {
        currentName = _tableData[rowNO];
      }
     //获取系统存储的城市列表,添加新城市,并存储到系统中
      NSMutableArray *cityArray = [[Config getCityList] mutableCopy];
     if (!cityArray) {
        NSMutableArray *cityFir = [[NSMutableArray alloc] initWithArray:@[currentName]];
        [Config setCityList:cityFir];
     }
     else
     {
       [cityArray addObject:currentName];
       [Config setCityList:cityArray];
     }
        //将当前选中城市设置为当前城市
        [Config setCurrentCityName:currentName];
        
        //跳转到weather界面
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
    
}

//添加索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",
                       @"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return array;
}

//点击索引的事件,跳转到指定分区
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 0;
}

#pragma mark- searchBarDelegate

// UISearchBarDelegate定义的方法，用户单击取消按钮时激发该方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // 取消搜索状态
    _isSearch = NO;
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}
// UISearchBarDelegate定义的方法，当搜索文本框内的文本改变时激发该方法
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchText];
}

// UISearchBarDelegate定义的方法，用户单击虚拟键盘上的Search按键时激发该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchBar.text];
    // 放弃作为第一个响应者，关闭键盘
    [searchBar resignFirstResponder];
}
- (void) filterBySubstring:(NSString*) subStr
{
    // 设置为搜索状态
    _isSearch = YES;
    // 定义搜索谓词
    NSPredicate* pred = [NSPredicate predicateWithFormat:
                         @"SELF CONTAINS[c] %@" , subStr];
    // 使用谓词过滤NSArray
    _searchData = [_tableData filteredArrayUsingPredicate:pred];
    // 让表格控件重新加载数据
    [self.tableView reloadData];
}


@end
