//
//  SGSceneryDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGEntertainmentDetailViewController.h"
#import "SGMapViewController.h"
#import "SGEntertainmentViewController.h"
#import "SGTextViewController.h"
#import "SGFavoriteHelper.h"

@interface SGEntertainmentDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *sImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *decriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *descriptionButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SGEntertainmentDetailViewController
{
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.entertainmentData.name;
    [self.descriptionButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    [self.detailButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    
    self.sImageView.image = [UIImage imageNamed:self.entertainmentData.imageUrl];
    self.addressLabel.text = self.entertainmentData.address;
    self.categoryLabel.text = self.entertainmentData.categoryName;
    self.decriptionLabel.text = self.entertainmentData.intro;
    self.detailLabel.text = self.entertainmentData.detail;

    self.scrollView.contentSize = CGSizeMake(320, 440);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    _favoButton = button;
    [self updateFavoriteState];
}

- (void)updateFavoriteState
{
    if ([[SGFavoriteHelper instance] isFavorite:self.entertainmentData.uid]) {
        [_favoButton setImage:[UIImage imageNamed:@"icon_collection_d"] forState:UIControlStateNormal];
    } else {
        [_favoButton setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    }
}

- (void)favoriteAction
{
    if ([[SGFavoriteHelper instance] isFavorite:self.entertainmentData.uid]) {
        [[SGFavoriteHelper instance] delFavorite:self.entertainmentData.uid type:FavoriteTypeEntertainment];
        [self showSplash:@"删除收藏成功"];
    } else {
        [[SGFavoriteHelper instance] addFavoriteWithEntertainment:self.entertainmentData];
        [self showSplash:@"添加收藏成功"];
    }
    [self updateFavoriteState];
}


- (IBAction)addressAction:(id)sender {
    SGMapViewController *mapViewController = [[SGMapViewController alloc] init];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:1];
    [list addObject:[[SGAnnotation alloc] initWithId:self.entertainmentData.uid
                                                 lat:self.entertainmentData.lat
                                                 lng:self.entertainmentData.lng
                                             address:self.entertainmentData.address
                                               title:self.entertainmentData.name
                                            subTitle:self.entertainmentData.intro
                                           leftImage:self.entertainmentData.imageUrl
                                                type:AnnotationTypeEntertainment]];
    [mapViewController setAnnotations:list];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (IBAction)categoryAction:(id)sender {
    SGEntertainmentViewController *viewController = [[SGEntertainmentViewController alloc] init];
    viewController.categoryName = self.entertainmentData.categoryName;
    viewController.title = self.entertainmentData.categoryName;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)descriptionAction:(id)sender {
    SGTextViewController *viewController = [[SGTextViewController alloc] init];
    viewController.title = self.entertainmentData.name;
    viewController.text = self.entertainmentData.intro;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)deatilAction:(id)sender {
    SGTextViewController *viewController = [[SGTextViewController alloc] init];
    viewController.title = self.entertainmentData.name;
    viewController.text = self.entertainmentData.detail;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSImageView:nil];
    [self setAddressLabel:nil];
    [self setCategoryLabel:nil];
    [self setDecriptionLabel:nil];
    [self setDetailLabel:nil];
    [self setDescriptionButton:nil];
    [self setDetailButton:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
