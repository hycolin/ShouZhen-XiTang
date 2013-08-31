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
            detailViewController.title = @"自驾";
            detailViewController.viewBundleName = @"TrafficDriveView";
            break;
        case TrafficTypeHighway:
            detailViewController.title = @"公路";
            detailViewController.viewBundleName = @"TrafficDefaultView";
            detailViewController.content = @"为方便游客出行，目前上海旅游集散中心（天天发班）、杭州旅游集散中心（周末发班）已开设西塘旅游专线车，上海、浙江、江苏的各大旅社均已开通西塘旅游线路。";
            break;
        case TrafficTypePlane:
            detailViewController.title = @"航空";
            detailViewController.viewBundleName = @"TrafficDefaultView";
            detailViewController.content = @"西塘距离上海浦东国际机场、杭州萧山国际机场、上海虹桥机场都在2小时车程之内，全程高速，道路通畅。";
            break;
        case TrafficTypeTrain:
            detailViewController.title = @"火车";
            detailViewController.viewBundleName = @"TrafficDefaultView";
            detailViewController.content = @"西塘地处上海、杭州、苏州的中心，全国各地到三地的火车班次密集，沪杭铁路途径嘉兴站及嘉善站，两地都有公交车直达西塘。";
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
