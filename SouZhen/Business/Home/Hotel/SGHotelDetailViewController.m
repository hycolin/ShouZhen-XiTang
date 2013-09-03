//
//  SGHotelDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHotelDetailViewController.h"
#import "SGHouseTypeDetailView.h"
#import "SGHotelDetailView.h"
#import "SGFavoriteHelper.h"

@interface SGHotelDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentLayoutView;
@property (weak, nonatomic) IBOutlet UIView *segmentedView;
@property (weak, nonatomic) IBOutlet UIButton *houseTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *hotelButton;


@end

@implementation SGHotelDetailViewController
{
    NSInteger _type;
    SGHouseTypeDetailView *_houseTypeDetailView;
    SGHotelDetailView *_hotelDetailView;
    UIButton *_favoButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)segmentedAction:(id)sender {
    self.houseTypeButton.selected = (self.houseTypeButton == sender);
    self.hotelButton.selected = (self.hotelButton == sender);
    [self switchType:(self.houseTypeButton == sender)?0:1];
}

- (void)switchType:(NSInteger)type
{
    _type = type;
    if (_type == 0) {
        if (_houseTypeDetailView == nil) {
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGHouseTypeDetailView" owner:nil options:nil];
            _houseTypeDetailView = [views objectAtIndex:0];
            _houseTypeDetailView.frame = self.contentLayoutView.bounds;
            [_houseTypeDetailView showData:self.houseTypeData];
        }
        [_hotelDetailView removeFromSuperview];
        [self.contentLayoutView addSubview:_houseTypeDetailView];
    } else if (type == 1) {
        if (_hotelDetailView == nil) {
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGHotelDetailView" owner:nil options:nil];
            _hotelDetailView = [views objectAtIndex:0];
            _hotelDetailView.frame = self.contentLayoutView.bounds;
            _hotelDetailView.hotelDetailController = self;
            [_hotelDetailView showData:self.hotelData];
        }
        [_houseTypeDetailView removeFromSuperview];
        [self.contentLayoutView addSubview:_hotelDetailView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.houseTypeButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.hotelButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];

    if (self.hotelData.houseList.count == 0) {
        self.segmentedView.hidden = YES;
        CGRect frame = self.contentLayoutView.frame;
        frame.origin.y = 0;
        frame.size.height += CGRectGetHeight(self.segmentedView.frame);
        self.contentLayoutView.frame = frame;
        _type = 1;
    }
    [self switchType:_type];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    _favoButton = button;
    [self updateFavoriteState];
}

- (void)updateFavoriteState
{
    if ([[SGFavoriteHelper instance] isFavorite:self.hotelData.uid]) {
        [_favoButton setImage:[UIImage imageNamed:@"icon_collection_d"] forState:UIControlStateNormal];
    } else {
        [_favoButton setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    }
}

- (void)favoriteAction
{
    if ([[SGFavoriteHelper instance] isFavorite:self.hotelData.uid]) {
        [[SGFavoriteHelper instance] delFavorite:self.hotelData.uid type:FavoriteTypeHotel];
        [self showSplash:@"删除收藏成功"];
    } else {
        [[SGFavoriteHelper instance] addFavoriteWithHotel:self.hotelData];
        [self showSplash:@"添加收藏成功"];
    }
    [self updateFavoriteState];
}


- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setContentLayoutView:nil];
    [self setSegmentedView:nil];
    [self setHouseTypeButton:nil];
    [self setHotelButton:nil];
    [super viewDidUnload];
}
@end
