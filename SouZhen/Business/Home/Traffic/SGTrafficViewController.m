//
//  SGTrafficViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGTrafficViewController.h"
#import "SGTrafficCell.h"
#import "SGTrafficDetailViewController.h"
#import "SGTrafficDriveDetailViewController.h"

typedef enum {
    TrafficTypeDrive = 0,
    TrafficTypeHighway,
    TrafficTypePlane,
    TrafficTypeTrain
} TrafficType;

@interface SGTrafficViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SGTrafficViewController
{
    NSArray *_typeList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 59;
    
    self.title = @"交通";
    _typeList = [NSArray arrayWithObjects:
                 [NSNumber numberWithInteger:TrafficTypeDrive],
                  [NSNumber numberWithInteger:TrafficTypeTrain],
                 [NSNumber numberWithInteger:TrafficTypeHighway],
                 [NSNumber numberWithInteger:TrafficTypePlane],
                 nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_typeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGTrafficCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TrafficCell"];
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGTrafficCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
    }
    TrafficType type = ((NSNumber *)[_typeList objectAtIndex:indexPath.row]).integerValue;
    switch (type) {
        case TrafficTypeDrive:
            [cell showTrafficIcon:@"icon_drive" name:@"自驾"];
            break;
        case TrafficTypeHighway:
            [cell showTrafficIcon:@"icon_highway" name:@"公路"];
            break;
        case TrafficTypePlane:
            [cell showTrafficIcon:@"icon_plane" name:@"航空"];
            break;
        case TrafficTypeTrain:
            [cell showTrafficIcon:@"icon_train" name:@"火车"];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SGTrafficDetailViewController *detailViewController = [[SGTrafficDetailViewController alloc] init];
    
    TrafficType type = ((NSNumber *)[_typeList objectAtIndex:indexPath.row]).integerValue;
    switch (type) {
        case TrafficTypeDrive:
            detailViewController = [[SGTrafficDriveDetailViewController alloc] init];
            detailViewController.title = @"自驾";
            detailViewController.viewBundleName = @"TrafficDriveView";
            detailViewController.titleIcon = @"icon_drive.png";
            break;
        case TrafficTypeHighway:
            detailViewController = [[SGTrafficDetailViewController alloc] init];
            detailViewController.title = @"公路";
            detailViewController.viewBundleName = @"TrafficHighwayView";
            detailViewController.titleIcon = @"icon_highway.png";
            detailViewController.contentSize = CGSizeMake(320, 1335);
            break;
        case TrafficTypePlane:
            detailViewController = [[SGTrafficDetailViewController alloc] init];
            detailViewController.title = @"航空";
            detailViewController.viewBundleName = @"TrafficPlaneView";
            detailViewController.titleIcon = @"icon_plane.png";
            break;
        case TrafficTypeTrain:
            detailViewController = [[SGTrafficDetailViewController alloc] init];
            detailViewController.title = @"火车";
            detailViewController.viewBundleName = @"TrafficTrainView";
            detailViewController.titleIcon = @"icon_train.png";
            detailViewController.contentSize = CGSizeMake(320, 496);
            break;
        default:
            break;
    }

    [self.navigationController pushViewController:detailViewController animated:YES];
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
