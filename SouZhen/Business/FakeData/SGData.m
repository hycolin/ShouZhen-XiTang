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

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [encoder encodeObject:self.categoryName forKey:@"categoryName"];
    [encoder encodeInteger:self.star forKey:@"star"];
    [encoder encodeDouble:self.price forKey:@"price"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeDouble:self.lat forKey:@"lat"];
    [encoder encodeDouble:self.lng forKey:@"lng"];
    [encoder encodeObject:self.intro forKey:@"intro"];
    [encoder encodeObject:self.tag forKey:@"tag"];
    [encoder encodeObject:self.way forKey:@"way"];
    [encoder encodeObject:self.houseList forKey:@"houseList"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.categoryName = [decoder decodeObjectForKey:@"categoryName"];
        self.star = [decoder decodeIntegerForKey:@"star"];
        self.price = [decoder decodeDoubleForKey:@"price"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.lat = [decoder decodeDoubleForKey:@"lat"];
        self.lng = [decoder decodeDoubleForKey:@"lng"];
        self.intro = [decoder decodeObjectForKey:@"intro"];
        self.tag = [decoder decodeObjectForKey:@"tag"];
        self.way = [decoder decodeObjectForKey:@"way"];
        self.houseList = [decoder decodeObjectForKey:@"houseList"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end

@implementation SGFoodData

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [encoder encodeObject:self.categoryName forKey:@"categoryName"];
    [encoder encodeDouble:self.price forKey:@"price"];
    [encoder encodeObject:self.intro forKey:@"intro"];
    [encoder encodeObject:self.material forKey:@"material"];
    [encoder encodeObject:self.cookbook forKey:@"cookbook"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.categoryName = [decoder decodeObjectForKey:@"categoryName"];
        self.price = [decoder decodeDoubleForKey:@"price"];
        self.intro = [decoder decodeObjectForKey:@"intro"];
        self.material = [decoder decodeObjectForKey:@"material"];
        self.cookbook = [decoder decodeObjectForKey:@"cookbook"];
    }
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end

@implementation SGEntertainmentData


//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [encoder encodeObject:self.categoryName forKey:@"categoryName"];
    [encoder encodeDouble:self.price forKey:@"price"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeDouble:self.lat forKey:@"lat"];
    [encoder encodeDouble:self.lng forKey:@"lng"];
    [encoder encodeObject:self.intro forKey:@"intro"];
    [encoder encodeObject:self.detail forKey:@"detail"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.categoryName = [decoder decodeObjectForKey:@"categoryName"];
        self.price = [decoder decodeDoubleForKey:@"price"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.lat = [decoder decodeDoubleForKey:@"lat"];
        self.lng = [decoder decodeDoubleForKey:@"lng"];
        self.intro = [decoder decodeObjectForKey:@"intro"];
        self.detail = [decoder decodeObjectForKey:@"detail"];
    }
    return self;
}

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


//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [encoder encodeDouble:self.price forKey:@"price"];
    [encoder encodeObject:self.intro forKey:@"intro"];
    [encoder encodeObject:self.bedding forKey:@"bedding"];
    [encoder encodeObject:self.size forKey:@"size"];
    [encoder encodeObject:self.facility forKey:@"facility"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.price = [decoder decodeDoubleForKey:@"price"];
        self.intro = [decoder decodeObjectForKey:@"intro"];
        self.bedding = [decoder decodeObjectForKey:@"bedding"];
        self.size = [decoder decodeObjectForKey:@"size"];
        self.facility = [decoder decodeObjectForKey:@"facility"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.uid, self.name];
}
@end