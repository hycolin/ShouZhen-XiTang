//
//  SGFakeDataHelper.m
//  SouZhen
//
//  Created by chenwang on 13-8-29.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGFakeDataHelper.h"
#import "sqlite3.h"

static SGFakeDataHelper *_instance;

@implementation SGFakeDataHelper
{
    sqlite3 *db;
}

+ (void)initialize
{
    _instance = [[SGFakeDataHelper alloc] init];
}

+ (SGFakeDataHelper *)instance
{
    return _instance;
}

- (id)init
{
    if (self = [super init]) {
        db = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"xitang" ofType:@"sqlite"];
        if(sqlite3_libversion_number() < 3006012) {
			if(sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
				sqlite3_close(db);
                
				return nil;
			}
		} else {
			if(sqlite3_open_v2([path UTF8String], &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL) != SQLITE_OK) {
				sqlite3_close(db);
				return nil;
			}
		}
    }
    return self;
}

- (NSString *)getStringAtColumn:(NSInteger)column stmt:(sqlite3_stmt *)stmt
{
    const char *str = (const char *)sqlite3_column_text(stmt, column);
    if (str != NULL && strlen(str) > 0) {
        NSString *str = [NSString stringWithCString:(const char *)sqlite3_column_text(stmt, column) encoding:NSUTF8StringEncoding];
        if ([str isEqualToString:@"NULL"]) {
            return nil;
        }
        return str;
    } else {
        return nil;
    }
}

- (NSInteger)getIntegerAtColumn:(NSInteger)column stmt:(sqlite3_stmt *)stmt
{
    return sqlite3_column_int(stmt, column);
}


- (double)getDoubleAtColumn:(NSInteger)column stmt:(sqlite3_stmt *)stmt
{
    return sqlite3_column_double(stmt, column);
}


//获取所有景点
- (NSArray *)getAllScenery
{
    return [self getSceneryListByCategory:nil];
}

- (SGSceneryData *)getSceneryByID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_scenery WHERE UID = '%@';", uid];
	sqlite3_stmt *stmt = NULL;
	SGSceneryData *scenery = nil;
	if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
		if(SQLITE_ROW == sqlite3_step(stmt)) {
			scenery = [[SGSceneryData alloc] init];
            scenery.uid = [self getStringAtColumn:0 stmt:stmt];
            scenery.name = [self getStringAtColumn:1 stmt:stmt];
            scenery.intro = [self getStringAtColumn:2 stmt:stmt];
            scenery.detail = [self getStringAtColumn:3 stmt:stmt];
            scenery.imageUrl = [self getStringAtColumn:4 stmt:stmt];
            scenery.categoryName = [self getStringAtColumn:5 stmt:stmt];
            scenery.star = [self getIntegerAtColumn:6 stmt:stmt];
            scenery.price = [self getDoubleAtColumn:7 stmt:stmt];
            scenery.address = [self getStringAtColumn:8 stmt:stmt];
            scenery.lat = [self getDoubleAtColumn:9 stmt:stmt];
            scenery.lng = [self getDoubleAtColumn:10 stmt:stmt];
		}
	}
	sqlite3_finalize(stmt);
	return scenery;
}

- (NSArray *)getSceneryListByCategory:(NSString *)categoryName
{
    const char *sql = NULL;
    if (categoryName.length == 0) {
        sql = "SELECT * FROM table_scenery;";
    } else {
        sql = [[NSString stringWithFormat:@"SELECT * FROM table_scenery WHERE categoryname = '%@';", categoryName] UTF8String];
    }

	sqlite3_stmt *stmt = NULL;
	NSMutableArray *array = nil;
	if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
		array = [[NSMutableArray alloc] initWithCapacity:30];
		while(SQLITE_DONE != sqlite3_step(stmt)) {
            SGSceneryData *scenery = [[SGSceneryData alloc] init];
            scenery.uid = [self getStringAtColumn:0 stmt:stmt];
            scenery.name = [self getStringAtColumn:1 stmt:stmt];
            scenery.intro = [self getStringAtColumn:2 stmt:stmt];
            scenery.detail = [self getStringAtColumn:3 stmt:stmt];
            scenery.imageUrl = [self getStringAtColumn:4 stmt:stmt];
            scenery.categoryName = [self getStringAtColumn:5 stmt:stmt];
            scenery.star = [self getIntegerAtColumn:6 stmt:stmt];
            scenery.price = [self getDoubleAtColumn:7 stmt:stmt];
            scenery.address = [self getStringAtColumn:8 stmt:stmt];
            scenery.lat = [self getDoubleAtColumn:9 stmt:stmt];
            scenery.lng = [self getDoubleAtColumn:10 stmt:stmt];
            [array addObject:scenery];
		}
	}
	sqlite3_finalize(stmt);
	NSArray *result = [array copy];
	return result;
}

//获取所有客栈
- (NSArray *)getAllHotel
{
    const char *sql = "SELECT * FROM table_hotel;";
	sqlite3_stmt *stmt = NULL;
	NSMutableArray *array = nil;
	if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
		array = [[NSMutableArray alloc] initWithCapacity:20];
		while(SQLITE_DONE != sqlite3_step(stmt)) {
            SGHotelData *data = [[SGHotelData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.imageUrl = [self getStringAtColumn:3 stmt:stmt];
            data.phone = [self getStringAtColumn:4 stmt:stmt];
            data.address = [self getStringAtColumn:5 stmt:stmt];
            data.lat = [self getDoubleAtColumn:6 stmt:stmt];
            data.lng = [self getDoubleAtColumn:7 stmt:stmt];
            data.tag = [self getStringAtColumn:8 stmt:stmt];
            data.way = [self getStringAtColumn:9 stmt:stmt];
            data.houseList = [self getHotelHouseTypeByID:data.uid];
            [array addObject:data];
		}
	}
	sqlite3_finalize(stmt);
	NSArray *result = [array copy];
	return result;
}

- (NSArray *)getHotelHouseTypeByID:(NSString *)hotelId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_hotel_housetype WHERE hotelid = '%@';", hotelId];
	sqlite3_stmt *stmt = NULL;
	NSMutableArray *array = nil;
	if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
		array = [[NSMutableArray alloc] initWithCapacity:20];
		while(SQLITE_DONE != sqlite3_step(stmt)) {
            SGHouseTypeData *data = [[SGHouseTypeData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.imageUrl = [self getStringAtColumn:3 stmt:stmt];
            data.price = [self getDoubleAtColumn:4 stmt:stmt];
            data.bedding = [self getStringAtColumn:5 stmt:stmt];
            data.size = [self getStringAtColumn:6 stmt:stmt];
            data.facility = [self getStringAtColumn:7 stmt:stmt];
            [array addObject:data];
		}
	}
	sqlite3_finalize(stmt);
	NSArray *result = [array copy];
	return result;
}

- (SGHotelData *)getHotelByID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_hotel WHERE UID = '%@';", uid];
	sqlite3_stmt *stmt = NULL;
	SGHotelData *data= nil;
	if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
		if(SQLITE_ROW == sqlite3_step(stmt)) {
			data = [[SGHotelData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.imageUrl = [self getStringAtColumn:3 stmt:stmt];
            data.phone = [self getStringAtColumn:4 stmt:stmt];
            data.address = [self getStringAtColumn:5 stmt:stmt];
            data.lat = [self getDoubleAtColumn:6 stmt:stmt];
            data.lng = [self getDoubleAtColumn:7 stmt:stmt];
            data.tag = [self getStringAtColumn:8 stmt:stmt];
            data.way = [self getStringAtColumn:9 stmt:stmt];
            data.houseList = [self getHotelHouseTypeByID:data.uid];
		}
	}
	sqlite3_finalize(stmt);
	return data;
}

//获取所有娱乐
- (NSArray *)getAllEntertainment
{
    return [self getEntertainmentListByCategory:nil];
}

- (SGEntertainmentData *)getEntertainmentByID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_entertainment WHERE UID = '%@';", uid];
	sqlite3_stmt *stmt = NULL;
	SGEntertainmentData *data= nil;
	if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
		if(SQLITE_ROW == sqlite3_step(stmt)) {
			data = [[SGEntertainmentData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.detail = [self getStringAtColumn:3 stmt:stmt];
            data.imageUrl = [self getStringAtColumn:4 stmt:stmt];
            data.categoryName = [self getStringAtColumn:5 stmt:stmt];
            data.address = [self getStringAtColumn:6 stmt:stmt];
            data.lat = [self getDoubleAtColumn:7 stmt:stmt];
            data.lng = [self getDoubleAtColumn:8 stmt:stmt];
		}
	}
	sqlite3_finalize(stmt);
	return data;
}

- (NSArray *)getEntertainmentListByCategory:(NSString *)categoryName
{
    const char *sql = nil;
    if (categoryName.length == 0) {
        sql = "SELECT * FROM table_entertainment;";
    } else {
        sql = [[NSString stringWithFormat:@"SELECT * FROM table_entertainment WHERE categoryname = '%@';", categoryName] UTF8String];
    }

	sqlite3_stmt *stmt = NULL;
	NSMutableArray *array = nil;
	if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
		array = [[NSMutableArray alloc] initWithCapacity:20];
		while(SQLITE_DONE != sqlite3_step(stmt)) {
            SGEntertainmentData *data = [[SGEntertainmentData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.detail = [self getStringAtColumn:3 stmt:stmt];
            data.imageUrl = [self getStringAtColumn:4 stmt:stmt];
            data.categoryName = [self getStringAtColumn:5 stmt:stmt];
            data.address = [self getStringAtColumn:6 stmt:stmt];
            data.lat = [self getDoubleAtColumn:7 stmt:stmt];
            data.lng = [self getDoubleAtColumn:8 stmt:stmt];
            [array addObject:data];
		}
	}
	sqlite3_finalize(stmt);
	NSArray *result = [array copy];
	return result;
}

//获取所有美食
- (NSArray *)getAllFood
{
    return [self getFoodListByCategory:nil];
}

- (SGFoodData *)getFoodByID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_entertainment WHERE UID = '%@';", uid];
	sqlite3_stmt *stmt = NULL;
	SGFoodData *data= nil;
	if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
		if(SQLITE_ROW == sqlite3_step(stmt)) {
			data = [[SGFoodData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.imageUrl = [self getStringAtColumn:3 stmt:stmt];
            data.categoryName = [self getStringAtColumn:4 stmt:stmt];
            data.price = [self getDoubleAtColumn:5 stmt:stmt];
            data.material = [self getStringAtColumn:6 stmt:stmt];
            data.cookbook = [self getStringAtColumn:7 stmt:stmt];
		}
	}
	sqlite3_finalize(stmt);
	return data;
}

- (NSArray *)getFoodListByCategory:(NSString *)categoryName
{
    const char *sql = nil;
    if (categoryName.length == 0) {
        sql = "SELECT * FROM table_food;";
    } else {
        sql = [[NSString stringWithFormat:@"SELECT * FROM table_food WHERE categoryname = '%@';", categoryName] UTF8String];
    }
    
	sqlite3_stmt *stmt = NULL;
	NSMutableArray *array = nil;
	if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
		array = [[NSMutableArray alloc] initWithCapacity:20];
		while(SQLITE_DONE != sqlite3_step(stmt)) {
            SGFoodData *data = [[SGFoodData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.imageUrl = [self getStringAtColumn:3 stmt:stmt];
            data.categoryName = [self getStringAtColumn:4 stmt:stmt];
            data.price = [self getDoubleAtColumn:5 stmt:stmt];
            data.material = [self getStringAtColumn:6 stmt:stmt];
            data.cookbook = [self getStringAtColumn:7 stmt:stmt];
            [array addObject:data];
		}
	}
	sqlite3_finalize(stmt);
	NSArray *result = [array copy];
	return result;
}

//获取资讯信息
- (NSArray *)getNewsByType:(NSString *)type
{
    const char *sql = [[NSString stringWithFormat:@"SELECT * FROM table_news WHERE type = '%@';", type] UTF8String];
    
	sqlite3_stmt *stmt = NULL;
	NSMutableArray *array = nil;
	if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
		array = [[NSMutableArray alloc] initWithCapacity:30];
		while(SQLITE_DONE != sqlite3_step(stmt)) {
            SGNewsData *data = [[SGNewsData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.title = [self getStringAtColumn:1 stmt:stmt];
            data.time = [self getStringAtColumn:2 stmt:stmt];
            data.content = [self getStringAtColumn:3 stmt:stmt];
            data.thumbImageUrl = [self getStringAtColumn:4 stmt:stmt];
            data.newsType = [self getStringAtColumn:5 stmt:stmt];
            [array addObject:data];
		}
	}
	sqlite3_finalize(stmt);
	NSArray *result = [array copy];
	return result;
}

//获取路线信息
- (SGRouteData *)getRouteByType:(RouteType)type
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_route WHERE type = %d;", type];
	sqlite3_stmt *stmt = NULL;
    SGRouteData *data= nil;
	if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
		if(SQLITE_ROW == sqlite3_step(stmt)) {
			data = [[SGRouteData alloc] init];
            data.uid = [self getStringAtColumn:0 stmt:stmt];
            data.name = [self getStringAtColumn:1 stmt:stmt];
            data.intro = [self getStringAtColumn:2 stmt:stmt];
            data.content = [self getStringAtColumn:3 stmt:stmt];
            data.type = [self getIntegerAtColumn:4 stmt:stmt];
		}
	}
	sqlite3_finalize(stmt);
	return data;
}


@end
