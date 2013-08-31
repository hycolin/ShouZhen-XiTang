//
//  SGRouteAnnotation.h
//  SouZhen
//
//  Created by chenwang on 13-8-22.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SGRouteUIInfo.h"

@interface SGRouteAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) SGRouteUIInfo *route;

- (id)initWithRoute:(SGRouteUIInfo *)route;

@end
