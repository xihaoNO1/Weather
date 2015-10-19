//
//  SceneryViewController.m
//  Weather
//
//  Created by xixixi on 15/10/12.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "SceneryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SceneryViewController ()

@end

#define  SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SceneryViewController
{
    NSMutableArray *_imageArray;
    ALAssetsLibrary *library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //处理系统collectionView的顶部留白
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    //设置导航栏的背景图片为透明
//    UIImage *image = [UIImage imageNamed:@"navi_bg.png"];
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:image];

    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //设置scrollView及pageControl的位置
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 144);
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置scrollview的contentsize
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 80);
    
    //设置分页控件
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 75,125, 150, 20)];

    self.pageControl.numberOfPages = (NSInteger) 3;
    self.pageControl.currentPage = (NSInteger) 0;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    

    
    [self.view addSubview:self.pageControl];
    
    //分别创建三个Imageview
    UIImageView * page1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    page1.image = [UIImage imageNamed:@"Snip20151012_2.png"];
    
    UIImageView * page2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 80)];
    page2.image = [UIImage imageNamed:@"Snip20151012_3.png"];
    
    UIImageView * page3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, 80)];
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
    
    
    _imageArray = [[NSMutableArray alloc] init];
    
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
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    

    
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
    iv.image = _imageArray[indexPath.row];
    iv.frame = cell.bounds;
    iv.contentMode = UIViewContentModeScaleAspectFill;
//    UILabel *lab = (UILabel *)[cell viewWithTag:2];
//    lab.backgroundColor = [UIColor redColor];
//    lab.text = [NSString stringWithFormat:@"美景%d",indexPath.row + 1];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
