
//
//  Config.m
//  Weather
//
//  Created by xixixi on 15/10/14.
//  Copyright © 2015年 xihao. All rights reserved.
//

#import "Config.h"

@implementation Config
{
    
}

+(NSString *)getCurrentCity:(NSDictionary *)information
{
    NSString *city = [[information objectForKey:@"results"][0] objectForKey:@"currentCity"];
    return city;
}
+(NSDictionary *)getCurrentInfo:(NSDictionary *)information
{
    NSDictionary *currentInfo = [[information objectForKey:@"results"][0] objectForKey:@"weather_data"][0];
    
    return currentInfo;
}

+(NSDictionary *)getTwodayInfo:(NSDictionary *)information
{
    NSDictionary *TwodayInfo = [[information objectForKey:@"results"][0]
                                objectForKey:@"weather_data"][1];
    return TwodayInfo;
}

+(NSDictionary *)getThreedayInfo:(NSDictionary *)information
{
    NSDictionary *ThreedayInfo = [[information objectForKey:@"results"][0]
                                objectForKey:@"weather_data"][2];
    return ThreedayInfo;
}
+(NSDictionary *)getFourdayInfo:(NSDictionary *)information
{
    NSDictionary *FourdayInfo = [[information objectForKey:@"results"][0]
                                  objectForKey:@"weather_data"][3];
    return FourdayInfo;
}
+(NSArray *)getCurrentLifeInfo:(NSDictionary *)information
{
    NSArray *lifeInfo = [[information objectForKey:@"results"][0] objectForKey:@"index"];
    return lifeInfo;
}

@end