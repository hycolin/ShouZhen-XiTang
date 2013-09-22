//
//  LocationManager.m
//  EDrivel
//
//  Created by chen wang on 11-12-21.
//  Copyright (c) 2011年 bonet365.com. All rights reserved.
//

#import "LocationManager.h"

static LocationManager *gLocationManager = nil;

@implementation LocationManager
@synthesize isLocationOk;
@synthesize coord = _coord;
@synthesize locationFaked;
@synthesize locationServiceDisable = _locationServiceDisable;

+ (LocationManager *)instance {
	if (gLocationManager == nil) {
		gLocationManager = [[LocationManager alloc] init];
	}
	return gLocationManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		_mPlacemark = nil;
		isLocationOk = NO;
        isShow=NO;
		locationManager = [[CLLocationManager alloc] init];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    
    return self;
}

- (void)start {
    _locationServiceDisable = ![CLLocationManager locationServicesEnabled];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.distanceFilter = 1;
#if TARGET_IPHONE_SIMULATOR
	// zhongshan park
	_coord.longitude = 121.419096;
	_coord.latitude = 31.215866;
    isLocationOk = YES;
//    [[NSNotificationCenter defaultCenter] postNotificationName:LocationChanged object:nil];
#else
	[locationManager startUpdatingLocation];
#endif
}

- (void)stop {
	[locationManager stopUpdatingLocation];
}

- (void)applicationWillResignActive {
	[self stop];
}

- (void)applicationDidBecomeActive {
	locationFaked = NO;
	[self start];
}


- (void)setChoosedCoord:(CLLocationCoordinate2D)c {
	[self stop];
	_coord = c;
	isLocationOk = YES;
	locationFaked = YES;
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[_mPlacemark release];
	_mPlacemark = nil;
}

#pragma mark -
#pragma mark CLLocationManager delegate
- (void) locationManager: (CLLocationManager *) manager 
	 didUpdateToLocation: (CLLocation *) newLocation
			fromLocation: (CLLocation *) oldLocation{
	[locationManager stopUpdatingLocation];
	_coord.longitude = newLocation.coordinate.longitude;
	_coord.latitude = newLocation.coordinate.latitude;
	dlog(@"loction: (%.6f, %.6f)", _coord.longitude, _coord.latitude);
    isLocationOk = YES;
    _locationServiceDisable = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationChanged object:nil];
}

- (void) locationManager: (CLLocationManager *) manager didFailWithError: (NSError *) error {
    dlog(@"locationManager error : %@",error);
	if ([error code] == kCLErrorDenied) {
        _locationServiceDisable = YES;
	}
	
	isLocationOk = NO;
	[[NSNotificationCenter defaultCenter] postNotificationName:LocationChanged object:nil];
}

-(double)latitude{
	return _coord.latitude;
}

-(double)longitude{
	return _coord.longitude;	
}

- (NSString *)city {
    return _mPlacemark.locality;
}

-(NSString*)locationString{
    if (_mPlacemark && [_mPlacemark isKindOfClass:[MKPlacemark class]]) {
        return [NSString stringWithFormat:@"%@%@%@%@"
                ,[_mPlacemark.locality isKindOfClass:[NSString class]] ? _mPlacemark.locality : @""
                ,[_mPlacemark.subLocality isKindOfClass:[NSString class]] ? _mPlacemark.subLocality : @""
                ,[_mPlacemark.thoroughfare isKindOfClass:[NSString class]] ? _mPlacemark.thoroughfare : @""
                ,[_mPlacemark.subThoroughfare isKindOfClass:[NSString class]] ? _mPlacemark.subThoroughfare : @""];
    } else {
        return @"获取当前位置失败";
    }
}

- (double_t)distanceFrom:(CLLocationCoordinate2D)fromCoord {
    double_t lat1 = fromCoord.latitude / 180.0 * M_PI;
    double_t lon1 = fromCoord.longitude / 180.0 * M_PI;
    double_t lat2 = _coord.latitude / 180.0 * M_PI;
    double_t lon2 = _coord.longitude / 180.0 * M_PI;
    double_t dlat = lat2 - lat1;
    double_t dlon = lon2 - lon1;
    
    double_t a = sin(dlat / 2.0) * sin(dlat / 2.0)
    + cos(lat1) * cos(lat2) * sin(dlon / 2.0) * sin(dlon / 2.0);
    double_t c = 2.0 * atan2(sqrt(a), sqrt(1.0 - a));
    return 6371000 * c;
}

- (NSString *)formatDistance:(double)distance {
	if (distance > 0) {
		int i = ((int)round(distance / 10.0)) * 10;
		if (i < 100) {
			return @"100m";
		} else if (i < 1000) {
			return [NSString stringWithFormat:@"%dm", i];
		} else if (i <10000) {
			double d = (double)i / 1000.0;
			return [NSString stringWithFormat:@"%.1fkm", d];
		} else if (i < 100000){
			int j = i/1000;
			return [NSString stringWithFormat:@"%dkm", j];
		} else {
			return @"约100km";
		}
	} else {
		return nil;
	}
}


- (void)dealloc {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[self stop];
	if (locationManager != nil){
		[locationManager release];
		locationManager = nil;
	}

	[_mPlacemark release];
	[super dealloc];
}

@end
