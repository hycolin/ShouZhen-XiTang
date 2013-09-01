//
//  FavoriteHelper.h
//  Macalline
//
//  Created by chen wang on 12-6-4.
//  Copyright (c) 2012年 YoMi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FavoriteTypeHotel,
    FavoriteTypeFood,
    FavoriteTypeEntertainment
} FavoriteType;

@interface SGFavoriteHelper : NSObject {
}
@property (nonatomic, readonly) NSArray *favoriteHotelList;
@property (nonatomic, readonly) NSArray *favoriteFoodList;
@property (nonatomic, readonly) NSArray *favoriteEntertainmentList;

+ (SGFavoriteHelper *)instance;

- (void)addFavoriteWithHotel:(SGHotelData *)hotel;
- (void)addFavoriteWithFood:(SGFoodData *)food;
- (void)addFavoriteWithEntertainment:(SGEntertainmentData *)entertainmentData;

- (void)delFavorite:(NSString *)pId type:(FavoriteType)type;

- (BOOL)isFavorite:(NSString *)uid;

@end
