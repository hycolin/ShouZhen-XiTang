//
//  SGSceneryData.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGData.h"

@implementation SGSceneryData

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end

@implementation SGHotelData
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end

@implementation SGFoodData
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end

@implementation SGEntertainmentData
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end

@implementation SGNewsData
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.title];
}
@end

@implementation SGRouteData
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end

@implementation SGHouseTypeData
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end