//
//  SGRouteData.h
//  SouZhen
//
//  Created by chenwang on 13-8-22.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SGRouteUIInfo : NSObject

@property (nonatomic) double lat;
@property (nonatomic) double lng;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *intro;
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSString *sceneryId;
@property (nonatomic) NSInteger index;

@property (nonatomic) BOOL header;
@property (nonatomic) BOOL fold;
@property (nonatomic) BOOL showFoldButton;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger titleHeight;
@property (nonatomic) NSInteger descriptionHeight;

@end

