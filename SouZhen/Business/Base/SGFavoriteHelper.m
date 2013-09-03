//
//  FavoriteHelper.m
//  Macalline
//
//  Created by chen wang on 12-6-4.
//  Copyright (c) 2012年 YoMi. All rights reserved.
//

#import "SGFavoriteHelper.h"

static SGFavoriteHelper *_instance;

@implementation SGFavoriteHelper
{
    NSMutableArray *_favoriteHotelList;
    NSMutableArray *_favoriteFoodList;
    NSMutableArray *_favoriteEntertainmentList;
}
@synthesize favoriteFoodList = _favoriteFoodList;
@synthesize favoriteHotelList = _favoriteHotelList;
@synthesize favoriteEntertainmentList = _favoriteEntertainmentList;

+ (void)initialize {
    _instance = [[SGFavoriteHelper alloc] init];
}

+ (SGFavoriteHelper *)instance {
    return _instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _favoriteHotelList = [[NSMutableArray alloc] initWithCapacity:20];
        _favoriteFoodList = [[NSMutableArray alloc] initWithCapacity:20];
        _favoriteEntertainmentList = [[NSMutableArray alloc] initWithCapacity:20];
        
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                            NSUserDomainMask, YES) objectAtIndex:0];
        [_favoriteHotelList addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"FavoriteHotel"]]];
        [_favoriteFoodList addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"FavoriteFood"]]];
        [_favoriteEntertainmentList addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"FavoriteEntertainment"]]];
    }
    return self;
}

- (void)saveFavoriteList:(NSArray *)list type:(FavoriteType)type {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask, YES) objectAtIndex:0];
    if (type == FavoriteTypeHotel) {
        [NSKeyedArchiver archiveRootObject:list toFile:[documentsDirectory stringByAppendingPathComponent:@"FavoriteHotel"]];
    } else if (type == FavoriteTypeFood) {
        [NSKeyedArchiver archiveRootObject:list toFile:[documentsDirectory stringByAppendingPathComponent:@"FavoriteFood"]];
    } else {
        [NSKeyedArchiver archiveRootObject:list toFile:[documentsDirectory stringByAppendingPathComponent:@"FavoriteEntertainment"]];
    }
}

- (void)addFavoriteWithHotel:(SGHotelData *)hotel
{
    if (!hotel || hotel.uid.length == 0 ) {
        return;
    }
    for (SGHotelData *data in _favoriteHotelList) {
        if ([data.uid isEqualToString:hotel.uid]) {
            [_favoriteHotelList removeObject:data];
            break;
        }
    }
    [_favoriteHotelList insertObject:hotel atIndex:0];
    [self saveFavoriteList:_favoriteHotelList type:FavoriteTypeHotel];
}

- (void)addFavoriteWithFood:(SGFoodData *)food
{
    if (!food || food.uid.length == 0 ) {
        return;
    }
    for (SGFoodData *data in _favoriteFoodList) {
        if ([data.uid isEqualToString:food.uid]) {
            [_favoriteFoodList removeObject:data];
            break;
        }
    }
    [_favoriteFoodList insertObject:food atIndex:0];
    [self saveFavoriteList:_favoriteFoodList type:FavoriteTypeFood];
}

- (void)addFavoriteWithEntertainment:(SGEntertainmentData *)entertainmentData
{
    if (!entertainmentData || entertainmentData.uid.length == 0 ) {
        return;
    }
    for (SGEntertainmentData *data in _favoriteEntertainmentList) {
        if ([data.uid isEqualToString:entertainmentData.uid]) {
            [_favoriteEntertainmentList removeObject:data];
            break;
        }
    }
    [_favoriteEntertainmentList insertObject:entertainmentData atIndex:0];
    [self saveFavoriteList:_favoriteEntertainmentList type:FavoriteTypeEntertainment];

}

- (void)delFavorite:(NSString *)pId type:(FavoriteType)type {
    if (type == FavoriteTypeHotel) {
        for (SGHotelData *data in _favoriteHotelList) {
            if ([data.uid isEqualToString:pId]) {
                [_favoriteHotelList removeObject:data];
                break;
            }
        }
        [self saveFavoriteList:_favoriteHotelList type:FavoriteTypeHotel];
    } else if (type == FavoriteTypeFood) {
        for (SGFoodData *data in _favoriteFoodList) {
            if ([data.uid isEqualToString:pId]) {
                [_favoriteFoodList removeObject:data];
                break;
            }
        }
        [self saveFavoriteList:_favoriteFoodList type:FavoriteTypeFood];
    } else if (type == FavoriteTypeEntertainment) {
        for (SGEntertainmentData *data in _favoriteEntertainmentList) {
            if ([data.uid isEqualToString:pId]) {
                [_favoriteEntertainmentList removeObject:data];
                break;
            }
        }
        [self saveFavoriteList:_favoriteEntertainmentList type:FavoriteTypeEntertainment];
    }
}

- (BOOL)isFavorite:(NSString *)pId
{
    for (SGHotelData *data in _favoriteHotelList) {
        if ([data.uid isEqualToString:pId]) {
            return YES;
        }
    }
    for (SGFoodData *data in _favoriteFoodList) {
        if ([data.uid isEqualToString:pId]) {
            return YES;
        }
    }
    for (SGEntertainmentData *data in _favoriteEntertainmentList) {
        if ([data.uid isEqualToString:pId]) {
            return YES;
        }
    }
    return NO;
}

- (void)dealloc {
}

@end
