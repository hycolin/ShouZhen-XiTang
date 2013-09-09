//
//  SGFavoriteViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGFavoriteViewController.h"
#import "SGFavoriteHelper.h"
#import "SGHotelCell.h"
#import "SGFoodCell.h"
#import "SGEntertainmentCell.h"
#import "SGHotelHouseTypeViewController.h"
#import "SGHotelDetailViewController.h"
#import "SGFoodDetailViewController.h"
#import "SGEntertainmentDetailViewController.h"
#import "SGAppDelegate.h"

@interface SGFavoriteViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *keyzhanButton;
@property (weak, nonatomic) IBOutlet UIButton *meshiButton;
@property (weak, nonatomic) IBOutlet UIButton *yuleButton;

@property (strong, nonatomic) IBOutlet UITableViewCell *emptyCell;

@end

@implementation SGFavoriteViewController
{
    FavoriteType _type;
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
    self.title = @"收藏";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.keyzhanButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.meshiButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.yuleButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    
    _type = FavoriteTypeHotel;
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    customView.backgroundColor = [UIColor clearColor];
    
    UIImage *menuImage = [UIImage imageNamed:@"icon_menu"];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 7, 50, 30);
    [menuButton setImage:menuImage forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:menuButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)menuAction
{
    if ([[SGAppDelegate instance].drawerController openSide] == MMDrawerSideNone) {
        [[SGAppDelegate instance].drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    } else {
        [[SGAppDelegate instance].drawerController closeDrawerAnimated:YES completion:nil];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self switchFavoriteType:_type];
}

- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}

- (IBAction)segmentedAction:(id)sender {
    self.keyzhanButton.selected = (self.keyzhanButton == sender);
    self.meshiButton.selected = (self.meshiButton == sender);
    self.yuleButton.selected = (self.yuleButton == sender);
    if (self.keyzhanButton.selected) {
        [self switchFavoriteType:FavoriteTypeHotel];
    } else if (self.meshiButton.selected) {
        [self switchFavoriteType:FavoriteTypeFood];
    } else {
        [self switchFavoriteType:FavoriteTypeEntertainment];
    }
}

- (void)switchFavoriteType:(FavoriteType)type
{
    _type = type;
    if (type == FavoriteTypeHotel) {
        self.list = [SGFavoriteHelper instance].favoriteHotelList;
    } else if (type == FavoriteTypeFood) {
        self.list = [SGFavoriteHelper instance].favoriteFoodList;
    } else {
        self.list = [SGFavoriteHelper instance].favoriteEntertainmentList;
    }
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointZero;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.list count] == 0) {
        return 1;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.list count]) {
        return self.emptyCell;
    }
    switch (_type) {
        case FavoriteTypeHotel:
        {
            SGHotelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGHotelCell"];
            if (!cell) {
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGHotelCell" owner:nil options:nil];
                cell = [views objectAtIndex:0];
            }
            [cell showData:[self.list objectAtIndex:indexPath.row]];
            return cell;
        }
        case FavoriteTypeFood:
        {
            SGFoodCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGFoodCell"];
            if (!cell) {
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGFoodCell" owner:nil options:nil];
                cell = [views objectAtIndex:0];
            }
            [cell showFood:[self.list objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case FavoriteTypeEntertainment:
        {
            SGEntertainmentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGEntertainmentCell"];
            if (!cell) {
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGEntertainmentCell" owner:nil options:nil];
                cell = [views objectAtIndex:0];
            }
            [cell showData:[self.list objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == [self.list count]) {
        return CGRectGetHeight(self.tableView.frame);
    }
    switch (_type) {
        case FavoriteTypeHotel:
        {
            return 100;
        }
            break;
        case FavoriteTypeFood:
        {
            return 85;
        }
            break;
        case FavoriteTypeEntertainment:
        {
            return 80;
        }
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [self.list count]) {
        return;
    }
    switch (_type) {
        case FavoriteTypeHotel:
        {
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
            break;
        case FavoriteTypeFood:
        {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            SGFoodDetailViewController *viewController = [[SGFoodDetailViewController alloc] init];
            viewController.food = [self.list objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case FavoriteTypeEntertainment:
        {
            SGEntertainmentDetailViewController *viewController = [[SGEntertainmentDetailViewController alloc] init];
            viewController.entertainmentData = [self.list objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setKeyzhanButton:nil];
    [self setMeshiButton:nil];
    [self setYuleButton:nil];
    [self setTableView:nil];
    [self setEmptyCell:nil];
    [super viewDidUnload];
}
@end
