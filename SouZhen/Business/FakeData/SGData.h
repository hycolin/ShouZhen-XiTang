//
//  SGSceneryData.h
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <Foundation/Foundation.h>

//景点
@interface SGSceneryData : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic) NSInteger star;
@property (nonatomic) double price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic) double lat;
@property (nonatomic) double lng;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *detail;

@end

//客栈
@interface SGHotelData : NSObject <NSCoding>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic) NSInteger star;
@property (nonatomic) double price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic) double lat;
@property (nonatomic) double lng;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *way;
@property (nonatomic, strong) NSArray *houseList;

@end

//房型
@interface SGHouseTypeData : NSObject <NSCoding>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic) double price;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *bedding;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *facility;

@end


//美食
@interface SGFoodData : NSObject <NSCoding>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic) double price;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *material;
@property (nonatomic, strong) NSString *cookbook;

@end


//娱乐
@interface SGEntertainmentData : NSObject <NSCoding>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic) double price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic) double lat;
@property (nonatomic) double lng;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *detail;

@end

//资讯
@interface SGNewsData : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *newsType;
@property (nonatomic, strong) NSString *thumbImageUrl;
@property (nonatomic, strong) NSString *time;
@property (nonatomic) double price;
@property (nonatomic, strong) NSString *content;

@end

//路线
@interface SGRouteData : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) RouteType type;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *content;

@end