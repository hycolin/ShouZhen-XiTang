//
//  SGFoodViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-1.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGFoodViewController.h"
#import "SGFakeDataHelper.h"
#import "SGFoodCell.h"
#import "SGFoodDetailViewController.h"

@interface SGFoodViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *specialtyButton;
@property (weak, nonatomic) IBOutlet UIButton *snacksButton;

@end

@implementation SGFoodViewController

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
    self.title = @"美食";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 85;
    
    [self.specialtyButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.snacksButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self switchCategory:@"特色菜"];
}

- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}

- (IBAction)segmentedAction:(id)sender {
    self.specialtyButton.selected = (self.specialtyButton == sender);
    self.snacksButton.selected = (self.snacksButton == sender);
    
    [self switchCategory:self.specialtyButton.selected?@"特色菜":@"特色小吃"];
}

- (void)switchCategory:(NSString *)categoryName
{
    self.list = [[SGFakeDataHelper instance] getFoodListByCategory:categoryName];
    
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointZero;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGFoodCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGFoodCell"];
    if (!cell) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGFoodCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
    }
    [cell showFood:[self.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    SGFoodDetailViewController *viewController = [[SGFoodDetailViewController alloc] init];
    viewController.food = [self.list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSpecialtyButton:nil];
    [self setSnacksButton:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
