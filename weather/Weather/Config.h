//
//  Config.h
//  Weather
//
//  Created by xixixi on 15/10/14.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "AppDelegate.h"

@interface Config : NSObject
@property (nonatomic, strong)NSDictionary *information;
//定义类方法
+(NSString *)getCurrentCity:(NSDictionary *)information;
+(NSDictionary *)getCurrentInfo:(NSDictionary *)information;
+(NSDictionary *)getTwodayInfo:(NSDictionary *)information;
+(NSDictionary *)getThreedayInfo:(NSDictionary *)information;
+(NSDictionary *)getFourdayInfo:(NSDictionary *)information;
+(NSArray *)getCurrentLifeInfo:(NSDictionary *)information;
@end
