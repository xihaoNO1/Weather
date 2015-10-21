//
//  SceneryViewController.m
//  Weather
//
//  Created by xixixi on 15/10/12.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "SceneryViewController.h"
#import <SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MJRefresh.h>

@interface SceneryViewController ()

@end

#define  SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SceneryViewController
{
    NSMutableArray *_imageArray;
//    ALAssetsLibrary *library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //处理系统collectionView的顶部留白
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    //设置scrollView及pageControl的位置
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置scrollview的contentsize
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);//设置为0 代表禁止垂直方向滚动
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:self.scrollView];
    
    
    //设置分页控件
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 75,90, 150, 20)];
    self.pageControl.numberOfPages = (NSInteger) 3;
    self.pageControl.currentPage = (NSInteger) 0;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    
    [self.view addSubview:self.pageControl];
    
    //分别创建三个Imageview
    UIImageView * page1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    page1.image = [UIImage imageNamed:@"Snip20151012_2.png"];
    
    UIImageView * page2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 120)];
    page2.image = [UIImage imageNamed:@"Snip20151012_3.png"];
    
    UIImageView * page3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, 120)];
    page3.image = [UIImage imageNamed:@"Snip20151012_4.png"];
    
    [self.scrollView addSubview:page1];
    [self.scrollView addSubview:page2];
    [self.scrollView addSubview:page3];
    self.scrollView.delegate = self;
    
    //collection
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 3 - 1, SCREEN_WIDTH / 3 - 1);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 1.0;
    self.collectionView.collectionViewLayout = layout;
    
    //初始化_imageArray,并plist文件中赋值
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Scenery" withExtension:@"plist"];
    _imageArray = [NSMutableArray arrayWithContentsOfURL:url];

    /* 占用内存过大 会被系统kill掉
    //从手机中导入相册
    library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:
                                        ^( ALAssetsGroup *group, BOOL *stop) {
       if (group) {
           [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
               if (result) {
                   ALAssetRepresentation *resentation = [result defaultRepresentation];
                   CGImageRef imageRef = resentation.fullResolutionImage;
                   UIImage *image = [UIImage imageWithCGImage:imageRef];
                   //将相片加入到数组中
                   [_imageArray addObject:image];
                  
                   if (_imageArray.count <=20) {
                        [self.collectionView reloadData];
                   }
                   else
                   {
                       return ;
                   }
               }
           }];
       }
       } failureBlock:^(NSError *error) {
   }];
     */
    
    //为collectionView添加上拉刷新和下拉刷新
    //下拉
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self
                                                               refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"赶紧放手,要刷新了!" forState:MJRefreshStatePulling];
    [header setTitle:@"使出吃奶的劲,刷新中......" forState:MJRefreshStateRefreshing];
    // 设置header
    self.collectionView.header = header;
    //上拉
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(loadMoreData)];
    
    // 马上进入刷新状态
    [self.collectionView.header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//下拉刷新数据请求,应用AFNetworking
- (void)loadNewData
{
    NSLog(@"没有最新数据");
    [NSThread sleepForTimeInterval:2];
    [self.collectionView.header endRefreshing];
}

//
- (void)loadMoreData
{
    //用现有网址数据模拟
    //初始化_imageArray,并plist文件中赋值
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Scenery" withExtension:@"plist"];
    NSArray *imageArray2 = [NSMutableArray arrayWithContentsOfURL:url];
    [_imageArray addObjectsFromArray:imageArray2];
    [self.collectionView reloadData];
    [self.collectionView.footer endRefreshing];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x / SCREEN_WIDTH;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前视图的宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据scrolView的左右滑动,对pageCotrol的当前指示器进行切换(设置currentPage)
    int page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    //切换改变页码，小圆点
    self.pageControl.currentPage = page;
}

#pragma mark -collectionViewDataSource and delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从可重用单元格队列中取出一个单元格
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    UIImageView *iv =(UIImageView *) [cell viewWithTag:1];
    NSString *urlStr = [_imageArray[indexPath.row] valueForKey:@"URL"];
    NSURL *URL = [NSURL URLWithString:urlStr];
    //异步下载,不保存到本地中
    [iv sd_setImageWithURL:URL placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    
    UILabel *lab = (UILabel *)[cell viewWithTag:3];
    lab.backgroundColor = [UIColor redColor];
    lab.text = [_imageArray[indexPath.row] valueForKey:@"Title"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
