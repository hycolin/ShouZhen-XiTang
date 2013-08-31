//
//  SGDefinition.h
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#ifndef SouZhen_SGDefinition_h
#define SouZhen_SGDefinition_h

typedef enum
{
    RouteType90 = 1000, //半日游
    RouteType120, //半日游
    RouteTypeBRY, //半日游
    RouteTypeYRY, //一日游
    RouteTypeLRY, //二日游
    RouteTypeYY, //夜游
    RouteTypeYSY //影视游
} RouteType;

#define    HotelServiceWIFI  @"免费无线wifi"
#define    HotelServiceHotWater @"24小时热水"
#define    HotelServiceFreeStay @"免费接站"
#define    HotelServiceCommissionSaleTicket @"代售门票"
#define    HotelServiceBicycleRental @"自行车租赁"
#define    HotelServiceCommissionSaleBus @"代售车票"
#define    HotelServiceGuide @"免费导游"
#define    HotelServicePickup @"免费接机"
#define    HotelServiceBCZC @"包车租车服务"
#define    HotelServiceCD @"垂钓"
#define    HotelServiceDJMXP @"代寄明信片"
#define    HotelServiceDDTC @"代售当地特产"
#define    HotelServiceHXJG @"海鲜加工"
#define    HotelServiceJX @"叫醒服务"
#define    HotelServiceYYZX @"旅游咨询"
#define    HotelServiceMiniMovie @"迷你电影院"
#define    HotelServiceFreeTea @"免费茶水"
#define    HotelServiceFreeJC @"免费寄存"
#define    HotelServiceFreePC @"免费品茶"
#define    HotelServiceFreeRead @"免费书刊阅读"
#define    HotelServiceFreeFruit @"免费水果"
#define    HotelServiceChess @"棋牌"
#define    HotelServiceFruitPick @"水果采摘"
#define    HotelServiceDrugs @"提供常用药品"
#define    HotelServicePort @"停车场"
#define    HotelServiceBRPG @"桌游"
#define    HotelServiceCuisine @"自助厨房"
#define    HotelServiceBarbecue @"自助烧烤"
#define    HotelServiceWash @"自助洗衣"

typedef enum {
    NewsTypeRecent, //最新动态
    NewsTypeTravel, //旅游资讯
    NewsTypeTopic, //专题活动
} NewsType;


#import "ECommon.h"
#import "SGData.h"

#endif
