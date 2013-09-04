//
//  SGTableViewController.h
//  SouZhen
//
//  Created by chenwang on 13-9-4.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGViewController.h"

@interface SGTableViewController : SGViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic) NSUInteger pageSize;

@end
