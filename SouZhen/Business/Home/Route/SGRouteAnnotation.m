//
//  SGRouteAnnotation.m
//  SouZhen
//
//  Created by chenwang on 13-8-22.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGRouteAnnotation.h"

@implementation SGRouteAnnotation
{
}

- (id)initWithRoute:(SGRouteUIInfo *)route
{
    self = [super init];
    if (self) {
        self.route = route;
    }
    return self;
}

- (NSString *)title
{
    return self.route.title;
}

- (NSString *)subtitle
{
    return self.route.intro;
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.route.lat, self.route.lng);
}

@end
