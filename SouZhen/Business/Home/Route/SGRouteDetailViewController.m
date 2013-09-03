//
//  SGRouteDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGRouteDetailViewController.h"
#import <MapKit/MapKit.h>
#import "SGRouteCell.h"
#import "SGRouteUIInfo.h"
#import "SGRouteAnnotation.h"
#import <QuartzCore/QuartzCore.h>
#import "SGFakeDataHelper.h"
#import "SGSceneryDetailViewController.h"

@interface SGRouteDetailViewController () <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, SGRouteCellDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *routeLayoutView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SGRouteDetailViewController
{
    NSMutableArray *_routeList;
}

- (id)init {
    self = [super init];
    if (self) {
        _routeList = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.routeLayoutView.layer.masksToBounds = NO;
    self.routeLayoutView.layer.shadowRadius = 5.f;
    self.routeLayoutView.layer.shadowOpacity = 0.4f;

    [self generateData];
}

- (void)generateData
{
    SGRouteData *routeData = [[SGFakeDataHelper instance] getRouteByType:self.routeType];
    if (routeData == nil) {
        return;
    }
    self.title = routeData.name;
    NSArray *scenerys = [routeData.content componentsSeparatedByString:@","];
    
    NSArray *arr = [routeData.intro componentsSeparatedByString:@","];
    NSString *headTitle = arr[0];
    NSString *tailTitle = arr.count > 1?arr[1]:nil;
    SGRouteUIInfo *data = [[SGRouteUIInfo alloc] init];
    data.title = headTitle;
    data.imageUrl = nil;
    data.header = YES;
    [_routeList addObject:data];
    for (int i=0; i<[scenerys count]; i++) {
        NSArray *arr = [((NSString *)scenerys[i]) componentsSeparatedByString:@"|"];
        if (arr.count == 1) { //为普通描述
            data = [[SGRouteUIInfo alloc] init];
            data.title = arr[0];
            data.header = YES;
            [_routeList addObject:data];
            continue;
        }
        NSString *sceneryId = arr[0];
        SGSceneryData *scenery = [[SGFakeDataHelper instance] getSceneryByID:sceneryId];
        if (scenery == nil) {
            continue;
        }
        NSString *title = arr.count > 1 ? arr[1] : scenery.name;
        
        data = [[SGRouteUIInfo alloc] init];
        data.title = title;
        data.lat = scenery.lat;
        data.lng = scenery.lng;
        data.sceneryId = sceneryId;
        data.intro = scenery.intro;
        data.imageUrl = scenery.imageUrl;
        [_routeList addObject:data];
    }
    
    if (tailTitle.length > 0) {
        SGRouteUIInfo *data = [[SGRouteUIInfo alloc] init];
        data.title = tailTitle;
        data.imageUrl = nil;
        data.header = YES;
        [_routeList addObject:data];
    }
    
    CLLocationCoordinate2D leftUpLocation = CLLocationCoordinate2DMake(0, 180);
    CLLocationCoordinate2D rightDownLocation = CLLocationCoordinate2DMake(90, 0);
    NSInteger index = 0;
    for (SGRouteUIInfo *data in _routeList) {
        [SGRouteCell calcRouteCelHeight:data fold:YES];
        if (data.header) {
            continue;
        }
        data.index = index;
        index++;
        
        leftUpLocation.latitude = MAX(ABS(leftUpLocation.latitude),ABS(data.lat));
        leftUpLocation.longitude = MIN(leftUpLocation.longitude, data.lng);
        
        rightDownLocation.latitude = MIN(ABS(rightDownLocation.latitude),ABS(data.lat));
        rightDownLocation.longitude = MAX(rightDownLocation.longitude, data.lng);
        
        SGRouteAnnotation *annotation = [[SGRouteAnnotation alloc] initWithRoute:data];

        [self.mapView addAnnotation:annotation];
    }
    MKCoordinateSpan span = MKCoordinateSpanMake(2*ABS(rightDownLocation.latitude - leftUpLocation.latitude),
                                                 2*ABS(rightDownLocation.longitude - leftUpLocation.longitude));
    CLLocationCoordinate2D center;
    center.latitude = (rightDownLocation.latitude + leftUpLocation.latitude) / 2;
    center.longitude = (rightDownLocation.longitude + leftUpLocation.longitude) / 2;

    MKCoordinateRegion displayRegion = MKCoordinateRegionMake(center,span);
    [self.mapView setRegion:displayRegion animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_routeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGRouteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RouteCell"];
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGRouteCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
        cell.delegate = self;
    }
    [cell showData:[_routeList objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((SGRouteUIInfo *)[_routeList objectAtIndex:indexPath.row]).height;
}

- (void)cellHeightChanged:(SGRouteCell *)cell
{
    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:NO];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled:animationsEnabled];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    SGRouteCell *cell = (SGRouteCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell foldAction:nil];
//    SGRouteUIInfo *routeUIInfo = [_routeList objectAtIndex:indexPath.row];
//    SGSceneryData *sceneryData = [[SGFakeDataHelper instance] getSceneryByID:routeUIInfo.sceneryId];
//    if (sceneryData) {
//        SGSceneryDetailViewController *viewController = [[SGSceneryDetailViewController alloc] init];
//        viewController.sceneryData = sceneryData;
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
}

#pragma mark - MapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pin = (MKAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:@"annotationsView"];
	if(pin == nil) {
		pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationsView"];
        pin.exclusiveTouch = YES;
        pin.draggable = NO;
        pin.canShowCallout = YES;
	} else {
		pin.annotation = annotation;
	}
    SGRouteAnnotation *routeAnno = annotation;
    if (routeAnno.route.imageUrl.length > 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:routeAnno.route.imageUrl]];
        imageView.frame = CGRectMake(0, 0, 32, 32);
        pin.leftCalloutAccessoryView = imageView;
    } else {
        pin.leftCalloutAccessoryView = nil;
    }
    
    UIImage *backgroundImage = [UIImage imageNamed:@"icon_db"];
    UIGraphicsBeginImageContextWithOptions(backgroundImage.size, NO, [UIScreen mainScreen].scale);
    CGContextRef cgContextRef = UIGraphicsGetCurrentContext();
    [backgroundImage drawAtPoint:CGPointMake(0, 0)];
    CGContextSetRGBFillColor(cgContextRef, 1.0, 1.0, 1.0, 1.0);
    NSString *pinNumber = [NSString stringWithFormat:@"%d", routeAnno.route.index  + 1];
    CGSize size = [pinNumber sizeWithFont:[UIFont systemFontOfSize:13]];
    [pinNumber drawAtPoint:CGPointMake((int)((backgroundImage.size.width - size.width)/2)+1, 6) withFont:[UIFont systemFontOfSize:13]];
    UIImage *pinImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    pin.image = pinImage;
    
    return pin;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [self setRouteLayoutView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end

