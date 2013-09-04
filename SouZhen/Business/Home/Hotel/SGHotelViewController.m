//
//  SGHotelViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHotelViewController.h"
#import "SGFakeDataHelper.h"
#import "SGHotelCell.h"
#import "SGHotelHouseTypeViewController.h"
#import "SGHotelDetailViewController.h"
#import "SGMapViewController.h"

@interface SGHotelViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SGHotelViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"客栈";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    
    self.list = [[SGFakeDataHelper instance] getAllHotel];
    
    UIButton *_mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mapButton.frame = CGRectMake(0, 0, 25, 25);
    [_mapButton setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
    [_mapButton addTarget:self action:@selector(switchMapAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_mapButton];
}

- (void)switchMapAction
{
    SGMapViewController *_mapViewController = [[SGMapViewController alloc] init];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:[self.list count]];
    for (SGHotelData *hotel in self.list) {
        SGAnnotation *anno = [[SGAnnotation alloc] initWithId:hotel.uid lat:hotel.lat lng:hotel.lng address:hotel.address title:hotel.name subTitle:hotel.intro leftImage:hotel.imageUrl type:AnnotationTypeHotel];
        [list addObject:anno];
    }
    [_mapViewController setAnnotations:list];
    [self.navigationController pushViewController:_mapViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGHotelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGHotelCell"];
    if (!cell) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGHotelCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
    }
    [cell showData:[self.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SGHotelData *hotel = (SGHotelData *)[self.list objectAtIndex:indexPath.row];
    if (hotel.houseList.count > 0) {
        SGHotelHouseTypeViewController *viewController = [[SGHotelHouseTypeViewController alloc] init];
        viewController.title = hotel.name;
        viewController.houseTypeList = hotel.houseList;
        viewController.hotelData = hotel;
        [self.navigationController pushViewController:viewController animated:YES];        
    } else {
        SGHotelDetailViewController *viewController = [[SGHotelDetailViewController alloc] init];
        viewController.title = hotel.name;
        viewController.hotelData = hotel;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
