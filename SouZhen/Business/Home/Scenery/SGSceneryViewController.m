//
//  SGSceneryViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGSceneryViewController.h"
#import "SGSceneryCell.h"
#import "SGSceneryDetailViewController.h"
#import "SGMapViewController.h"
#import "SGFakeDataHelper.h"

@interface SGSceneryViewController ()

@end

@implementation SGSceneryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    [self generateData];
    
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
    for (SGSceneryData *scenery in self.list) {
        SGAnnotation *anno = [[SGAnnotation alloc] initWithId:scenery.uid lat:scenery.lat lng:scenery.lng address:scenery.address title:scenery.name subTitle:scenery.intro leftImage:scenery.imageUrl type:AnnotationTypeScenery];
        [list addObject:anno];
    }
    [_mapViewController setAnnotations:list];
    [self.navigationController pushViewController:_mapViewController animated:YES];
}

- (void)generateData
{
    self.list = [NSArray arrayWithArray:[[SGFakeDataHelper instance] getSceneryListByCategory:self.categoryName]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGSceneryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGSceneryCell"];
    if (!cell) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGSceneryCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
    }
    [cell showSceneryData:[self.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    SGSceneryDetailViewController *viewController = [[SGSceneryDetailViewController alloc] init];
    viewController.sceneryData = [self.list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
