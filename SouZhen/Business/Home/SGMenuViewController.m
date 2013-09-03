//
//  SGMenuViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGMenuViewController.h"
#import "SGAppDelegate.h"
#import "SGHomeViewController.h"
#import "SGBookViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SGAnnotation.h"
#import "SGFakeDataHelper.h"

@interface SGMenuViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation SGMenuViewController

- (id)init
{
    self = [super initWithNibName:@"SGMenuViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bgImageView.layer.masksToBounds = YES;
    self.bgImageView.layer.shadowRadius = 10.f;
    
    [self updateButtonSelectedState:self.homeButton];
}

- (void)updateButtonSelectedState:(UIButton *)button
{
    self.homeButton.selected = (button == self.homeButton);
    self.bookButton.selected = (button == self.bookButton);
    self.mapButton.selected = (button == self.mapButton);
    self.favoriteButton.selected = (button == self.favoriteButton);
    self.moreButton.selected = (button == self.moreButton);
}

- (void)selectButton:(UIButton *)button
{
    if (button == self.homeButton) {
        YMCoverNavigationViewController *navigationController = [[YMCoverNavigationViewController alloc] initWithRootViewController:[SGAppDelegate instance].homeController];
        [[[SGAppDelegate instance] drawerController] setCenterViewController:navigationController];
    } else if (button == self.bookButton) {
        YMCoverNavigationViewController *navigationController = [[YMCoverNavigationViewController alloc] initWithRootViewController:[SGAppDelegate instance].bookController];
        [[[SGAppDelegate instance] drawerController] setCenterViewController:navigationController];
    } else if (button == self.favoriteButton) {
        YMCoverNavigationViewController *navigationController = [[YMCoverNavigationViewController alloc] initWithRootViewController:[SGAppDelegate instance].favoriteController];
        [[[SGAppDelegate instance] drawerController] setCenterViewController:navigationController];
    } else if (button == self.mapButton) {
        [self gotoMap];
    } else {
        YMCoverNavigationViewController *navigationController = [[YMCoverNavigationViewController alloc] initWithRootViewController:[SGAppDelegate instance].moreController];
        [[[SGAppDelegate instance] drawerController] setCenterViewController:navigationController];
    }
    [self updateButtonSelectedState:button];
   [[[SGAppDelegate instance] drawerController] closeDrawerAnimated:YES completion:nil];
}

- (void)gotoMap
{
    YMCoverNavigationViewController *navigationController = [[YMCoverNavigationViewController alloc] initWithRootViewController:[SGAppDelegate instance].mapController];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:10];
    NSArray *sceneryList = [[SGFakeDataHelper instance] getAllScenery];
    for (SGSceneryData *scenery in sceneryList) {
        SGAnnotation *anno = [[SGAnnotation alloc] initWithId:scenery.uid lat:scenery.lat lng:scenery.lng address:scenery.address title:scenery.name subTitle:scenery.intro leftImage:scenery.imageUrl type:AnnotationTypeScenery];
        [list addObject:anno];
    }
    NSArray *hotelList = [[SGFakeDataHelper instance] getAllHotel];
    for (SGHotelData *hotel in hotelList) {
        SGAnnotation *anno = [[SGAnnotation alloc] initWithId:hotel.uid lat:hotel.lat lng:hotel.lng address:hotel.address title:hotel.name subTitle:hotel.intro leftImage:hotel.imageUrl type:AnnotationTypeHotel];
        [list addObject:anno];
    }
    NSArray *entertainmentList = [[SGFakeDataHelper instance] getAllEntertainment];
    for (SGEntertainmentData *entertainment in entertainmentList) {
        SGAnnotation *anno = [[SGAnnotation alloc] initWithId:entertainment.uid lat:entertainment.lat lng:entertainment.lng address:entertainment.address title:entertainment.name subTitle:entertainment.intro leftImage:entertainment.imageUrl type:AnnotationTypeEntertainment];
        [list addObject:anno];
    }

    [[SGAppDelegate instance].mapController setAnnotations:list];
    
    [[[SGAppDelegate instance] drawerController] setCenterViewController:navigationController];
}

- (IBAction)buttonAction:(id)sender {
    [self selectButton:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBgImageView:nil];
    [self setHomeButton:nil];
    [self setBookButton:nil];
    [self setMapButton:nil];
    [self setFavoriteButton:nil];
    [self setMoreButton:nil];
    [super viewDidUnload];
}
@end
