//
//  SceneryViewController.h
//  Weather
//
//  Created by xixixi on 15/10/12.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneryViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)UIPageControl *pageControl;
@end
