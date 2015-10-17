//
//  getLocationCity.h
//  Weather
//
//  Created by xixixi on 15/10/17.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface getLocationCity : NSObject<CLLocationManagerDelegate>

@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic, strong)NSString *cityName;

- (void)getLocationCity;

@end
