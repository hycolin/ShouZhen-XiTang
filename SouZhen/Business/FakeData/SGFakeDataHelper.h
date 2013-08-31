//
//  SGFakeDataHelper.h
//  SouZhen
//
//  Created by chenwang on 13-8-29.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGFakeDataHelper : NSObject

+ (SGFakeDataHelper *)instance;

//获取所有景点
- (NSArray *)getAllScenery;
- (SGSceneryData *)getSceneryByID:(NSString *)uid;
- (NSArray *)getSceneryListByCategory:(NSString *)categoryName;

//获取所有客栈
- (NSArray *)getAllHotel;
- (SGHotelData *)getHotelByID:(NSString *)uid;


//获取所有娱乐
- (NSArray *)getAllEntertainment;
- (SGEntertainmentData *)getEntertainmentByID:(NSString *)uid;
- (NSArray *)getEntertainmentListByCategory:(NSString *)categoryName;

//获取所有美食
- (NSArray *)getAllFood;
- (SGFoodData *)getFoodByID:(NSString *)uid;
- (NSArray *)getFoodListByCategory:(NSString *)categoryName;

//获取资讯信息
- (NSArray *)getNewsByType:(NSString *)type;

//获取路线信息
- (SGRouteData *)getRouteByType:(RouteType)type;

@end
