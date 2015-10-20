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

//定义类方法

+(NSString *)getCurrentCity:(NSDictionary *)information;
+(NSDictionary *)getCurrentInfo:(NSDictionary *)information;
+(NSDictionary *)getTwodayInfo:(NSDictionary *)information;
+(NSDictionary *)getThreedayInfo:(NSDictionary *)information;
+(NSDictionary *)getFourdayInfo:(NSDictionary *)information;
+(NSArray *)getCurrentLifeInfo:(NSDictionary *)information;

//存储左侧视图的列表
+ (void)setCityList:(NSMutableArray *)cityArray;
+ (void)setAriList:(NSMutableArray *)ariArray;
+ (void)setCityData:(NSDictionary *)cityData forCityNamw:(NSString *)cityName;
//获取左视图的列表
+ (NSMutableArray *)getCityList;
+ (NSMutableArray *)getAriList;
+ (NSDictionary *)getCityData:(NSString *)cityName;
//设置当前城市名
+ (void)setCurrentCityName:(NSString *)CurrentCityName;
+ (NSString *)getCurrentCityName;

@end
