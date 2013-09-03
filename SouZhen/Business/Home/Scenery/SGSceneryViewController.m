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

@interface SGSceneryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SGSceneryViewController
{
    NSMutableArray *_list;
}

- (id)init
{
    self = [super init];
    if (self) {
        _list = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:[_list count]];
    for (SGSceneryData *scenery in _list) {
        SGAnnotation *anno = [[SGAnnotation alloc] initWithId:scenery.uid lat:scenery.lat lng:scenery.lng address:scenery.address title:scenery.name subTitle:scenery.intro leftImage:scenery.imageUrl type:AnnotationTypeScenery];
        [list addObject:anno];
    }
    [_mapViewController setAnnotations:list];
    [self.navigationController pushViewController:_mapViewController animated:YES];
}

- (void)generateData
{
    [_list removeAllObjects];
    [_list addObjectsFromArray:[[SGFakeDataHelper instance] getSceneryListByCategory:self.categoryName]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGSceneryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGSceneryCell"];
    if (!cell) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGSceneryCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
    }
    [cell showSceneryData:[_list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    SGSceneryDetailViewController *viewController = [[SGSceneryDetailViewController alloc] init];
    viewController.sceneryData = [_list objectAtIndex:indexPath.row];
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
