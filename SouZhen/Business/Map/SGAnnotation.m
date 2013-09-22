//
//  SGAnnotation.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGAnnotation.h"

@implementation SGAnnotation
{
    NSString *_uid;
    NSString *_title;
    NSString *_subTitle;
    NSString *_leftImage;
    AnnotationType _type;
    CLLocationCoordinate2D _coordinate;
    NSString *_address;
}

- (id)initWithId:(NSString *)uid
             lat:(double)lat
             lng:(double)lng
         address:(NSString *)address
           title:(NSString *)title
        subTitle:(NSString *)subTitle
       leftImage:(NSString *)leftImage
            type:(AnnotationType)type
{
    self = [super init];
    if (self) {
        _uid = uid;
        _coordinate = CLLocationCoordinate2DMake(lat, lng);
        _address = address;
        _title = title;
        _subTitle = subTitle;
        _leftImage = leftImage;
        _type = type;
    }
    return self;
}

- (NSString *)uid
{
    return _uid;
}

- (NSString *)leftImage
{
    return _leftImage;
}

- (AnnotationType)type
{
    return _type;
}

- (NSString *)title
{
    return _title;
}

- (NSString *)subtitle
{
    return _subTitle;
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

- (NSString *)address
{
    return _address;
}

@end

@implementation SGUserLocationForAnnotation

@dynamic coordinate;

#pragma mark MKAnnotation protocol
- (CLLocationCoordinate2D) coordinate {
	CLLocationCoordinate2D coordinatePoint = _coordinate;
	return coordinatePoint;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
	_coordinate = newCoordinate;
}

- (NSString*) title {
	return @"当前位置";
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate {
	if (self = [super init]) {
		_coordinate = coordinate;
	}
	return self;
}

@end

@implementation SGUserLocationAnnotationView


- (id) initWithAnnotation:(id <MKAnnotation>) pAnnotation
{
	self = [super initWithAnnotation:pAnnotation reuseIdentifier:@"UserLocationAnnotation"];
	if (self != nil) {
		// Initialization code
		
		self.multipleTouchEnabled = NO;
		self.canShowCallout = YES;
		self.backgroundColor = [UIColor clearColor];
		
		self.image = [UIImage imageNamed:@"UserLocation.png"];
		CGRect frame;
		frame.origin = CGPointMake(0, 0);
		frame.size = self.image.size;
		self.frame = frame;
		
	}
    return self;
}
@end

