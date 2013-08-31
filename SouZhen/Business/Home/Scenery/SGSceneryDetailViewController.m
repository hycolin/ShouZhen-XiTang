//
//  SGSceneryDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGSceneryDetailViewController.h"
#import "SGMapViewController.h"
#import "SGSceneryViewController.h"
#import "SGTextViewController.h"

@interface SGSceneryDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *sImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *decriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *descriptionButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SGSceneryDetailViewController

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
    self.title = self.sceneryData.name;
    [self.descriptionButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    [self.detailButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    
    self.sImageView.image = [UIImage imageNamed:self.sceneryData.imageUrl];
    self.addressLabel.text = self.sceneryData.address;
    self.categoryLabel.text = self.sceneryData.categoryName;
    self.decriptionLabel.text = self.sceneryData.intro;
    self.detailLabel.text = self.sceneryData.detail;

    self.scrollView.contentSize = CGSizeMake(320, 440);
}

- (IBAction)addressAction:(id)sender {
    SGMapViewController *mapViewController = [[SGMapViewController alloc] init];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:1];
    [list addObject:[[SGAnnotation alloc] initWithId:self.sceneryData.uid
                                                 lat:self.sceneryData.lat
                                                 lng:self.sceneryData.lng
                                             address:self.sceneryData.address
                                               title:self.sceneryData.name
                                            subTitle:self.sceneryData.intro
                                           leftImage:self.sceneryData.imageUrl
                                                type:AnnotationTypeScenery]];
    [mapViewController setAnnotations:list];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (IBAction)categoryAction:(id)sender {
    SGSceneryViewController *viewController = [[SGSceneryViewController alloc] init];
    viewController.categoryName = self.sceneryData.categoryName;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)descriptionAction:(id)sender {
    SGTextViewController *viewController = [[SGTextViewController alloc] init];
    viewController.title = self.sceneryData.name;
    viewController.text = self.sceneryData.intro;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)deatilAction:(id)sender {
    SGTextViewController *viewController = [[SGTextViewController alloc] init];
    viewController.title = self.sceneryData.name;
    viewController.text = self.sceneryData.detail;
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
