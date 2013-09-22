//
//  SGTableViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-4.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGTableViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface SGTableViewController () <EGORefreshTableHeaderDelegate>

@end

@implementation SGTableViewController
{
    EGORefreshTableHeaderView *refreshHeaderViewPullUp;
    BOOL _reloading;
    NSMutableArray *_list;
    NSInteger _startIndex;
}
@synthesize list = _list;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageSize = 10;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    refreshHeaderViewPullUp = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, self.tableView.contentSize.height, 320, 650) withStyle:EGOPullUp hiddenUpdatedStatus:YES];
    refreshHeaderViewPullUp.delegate = self;
    [self.tableView addSubview:refreshHeaderViewPullUp];
    refreshHeaderViewPullUp.hidden = YES;
    
    [self performSelector:@selector(configRefreshHeaderView) withObject:nil afterDelay:0.1];
}

- (void)configRefreshHeaderView {
    BOOL hidden = (_startIndex +  self.pageSize) >= [self.list count];
    refreshHeaderViewPullUp.hidden = hidden;
    refreshHeaderViewPullUp.statusText = @"加载更多";
    CGRect frame = refreshHeaderViewPullUp.frame;
    frame.origin.y = self.tableView.contentSize.height;
    refreshHeaderViewPullUp.frame = frame;
    
    _reloading = NO;
    [refreshHeaderViewPullUp egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)loadNext
{
    _startIndex += self.pageSize;
    [self.tableView reloadData];
    
    [self performSelector:@selector(configRefreshHeaderView) withObject:nil afterDelay:0.001];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_startIndex + self.pageSize < [self.list count]) {
        return _startIndex + self.pageSize;
    } else {
        return [self.list count];
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
	_reloading = YES;
    [self performSelector:@selector(loadNext) withObject:nil afterDelay:0.01];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return _reloading; // should return if data source model is reloading
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (refreshHeaderViewPullUp.hidden) {
        return;
    }
    [refreshHeaderViewPullUp egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (refreshHeaderViewPullUp.hidden) {
        return;
    }
    [refreshHeaderViewPullUp egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
