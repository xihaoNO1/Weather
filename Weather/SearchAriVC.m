//
//  SearchAriVC.m
//  Weather
//
//  Created by xixixi on 15/10/19.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "SearchAriVC.h"

@interface SearchAriVC ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchAriVC
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)tapleftBarButtonItem:(id)sender {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
