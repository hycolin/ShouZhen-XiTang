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
#import "SGHotelHouseTypeViewController.h"
#import "SGHotelDetailViewController.h"
#import "SGFoodDetailViewController.h"

@interface SGFavoriteViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *keyzhanButton;
@property (weak, nonatomic) IBOutlet UIButton *meshiButton;
@property (weak, nonatomic) IBOutlet UIButton *yuleButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SGFavoriteViewController
{
    NSArray *_list;
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
    
    [self switchFavoriteType:FavoriteTypeHotel];
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
        _list = [SGFavoriteHelper instance].favoriteHotelList;
    } else if (type == FavoriteTypeHotel) {
        _list = [SGFavoriteHelper instance].favoriteFoodList;
    } else {
        _list = [SGFavoriteHelper instance].favoriteEntertainmentList;
    }
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointZero;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_type) {
        case FavoriteTypeHotel:
        {
            SGHotelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGHotelCell"];
            if (!cell) {
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGHotelCell" owner:nil options:nil];
                cell = [views objectAtIndex:0];
            }
            [cell showData:[_list objectAtIndex:indexPath.row]];
            return cell;
        }
        case FavoriteTypeFood:
        {
            SGFoodCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SGFoodCell"];
            if (!cell) {
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGFoodCell" owner:nil options:nil];
                cell = [views objectAtIndex:0];
            }
            [cell showFood:[_list objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case FavoriteTypeEntertainment:
        {
            
        }
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
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
            
        }
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (_type) {
        case FavoriteTypeHotel:
        {
            SGHotelData *hotel = (SGHotelData *)[_list objectAtIndex:indexPath.row];
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
            viewController.food = [_list objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case FavoriteTypeEntertainment:
        {
            
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
    [super viewDidUnload];
}
@end
