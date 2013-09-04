//
//  SGNewsViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-1.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGNewsViewController.h"
#import "SGNewsCell.h"
#import "SGFakeDataHelper.h"
#import "SGNewsDetailViewController.h"

@interface SGNewsViewController () <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *zxdtButton;
@property (weak, nonatomic) IBOutlet UIButton *yyzxButton;
@property (weak, nonatomic) IBOutlet UIButton *zthdButton;

@end

@implementation SGNewsViewController
{
    NSString *_type;
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
    self.title = @"西塘动态";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    
    [self switchNewsType:@"最新动态"];
    
    [self.zxdtButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.yyzxButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.zthdButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
}

- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}

- (IBAction)segmentedAction:(id)sender {
    self.zxdtButton.selected = (self.zxdtButton == sender);
    self.yyzxButton.selected = (self.yyzxButton == sender);
    self.zthdButton.selected = (self.zthdButton == sender);
    if (self.zxdtButton.selected) {
        [self switchNewsType:@"最新动态"];
    } else if (self.yyzxButton.selected) {
        [self switchNewsType:@"旅游资讯"];
    } else {
        [self switchNewsType:@"专题活动"];
    }
}

- (void)switchNewsType:(NSString *)type
{
    _type = type;
    self.list = [[SGFakeDataHelper instance] getNewsByType:_type];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGNewsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGNewsCell"];
    if (!cell) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGNewsCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
    }
    [cell showData:[self.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    SGNewsDetailViewController *viewController = [[SGNewsDetailViewController alloc] init];
    viewController.news = [self.list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setZxdtButton:nil];
    [self setYyzxButton:nil];
    [self setZthdButton:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
