//
//  SGHomeViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHomeViewController.h"
#import "SGAppDelegate.h"
#import "SGRouteViewController.h"
#import "SGTrafficViewController.h"
#import "SGSceneryViewController.h"
#import "SGStrategyViewController.h"
#import "SGHotelViewController.h"
#import "SGFoodViewController.h"
#import "SGEntertainmentViewController.h"
#import "SGNewsViewController.h"
#import "SimpleFliperView.h"
#import "SGBannerViewCell.h"
#import "SGSceneryDetailViewController.h"
#import "SGFakeDataHelper.h"

typedef enum {
    HomeIndexRoute = 1000,
    HomeIndexStrategy,
    HomeIndexTraffic,
    HomeIndexScenery,
    HomeIndexHotel,
    HomeIndexFood,
    HomeIndexEntertainment,
    HomeIndexNews
}HomeIndex;

@interface SGHomeViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *bannerPageControl;
@property (weak, nonatomic) IBOutlet SimpleFliperView *bannerView;


@end

@implementation SGHomeViewController

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
    self.title = @"西塘"; 
    
    self.bannerView.cellClass = [SGBannerViewCell class];
    self.bannerView.autoFliper = YES;
    self.bannerView.dataArray = [NSArray arrayWithObjects:
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"banner_0.png", @"image", @"s0004", @"uid", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"banner_1.png", @"image", @"s0014", @"uid", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"banner_2.png", @"image", @"s0003", @"uid", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"banner_3.png", @"image", @"s0002", @"uid", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"banner_4.png", @"image", @"s0012", @"uid", nil],
                                 nil];
    [self.bannerView setSelectedTarget:self selector:@selector(bannerSelected:)];
    
    self.bannerScrollview.contentSize = CGSizeMake(1600, CGRectGetHeight(self.bannerScrollview.frame));
    self.bannerScrollview.delegate = self;
}

- (void)bannerSelected:(NSDictionary*)banner
{
    NSString *sceneryId = [banner objectForKey:@"uid"];
    SGSceneryDetailViewController *viewController = [[SGSceneryDetailViewController alloc] init];
    viewController.sceneryData = [[SGFakeDataHelper instance] getSceneryByID:sceneryId];
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / 320;
    self.bannerPageControl.currentPage = index;
}

- (IBAction)homeIndexAction:(id)sender
{
    UIButton *button = sender;
    HomeIndex index = button.tag;
    switch (index) {
        case HomeIndexRoute: //路线
        {
            SGRouteViewController *viewController = [[SGRouteViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexStrategy: //攻略
        {
            SGStrategyViewController *viewController = [[SGStrategyViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexTraffic: //交通
        {
            SGTrafficViewController *viewController = [[SGTrafficViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexScenery: //景点
        {
            SGSceneryViewController *viewController = [[SGSceneryViewController alloc] init];
            viewController.title = @"景点";
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexHotel: //客栈
        {
            SGHotelViewController *viewController = [[SGHotelViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexFood: //美食
        {
            SGFoodViewController *viewController = [[SGFoodViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexEntertainment: //娱乐
        {
            SGEntertainmentViewController *viewController = [[SGEntertainmentViewController alloc] init];
            viewController.title = @"娱乐";
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexNews: //资讯
        {
            SGNewsViewController *viewController = [[SGNewsViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBannerScrollview:nil];
    [self setBannerPageControl:nil];
    [self setBannerView:nil];
    [super viewDidUnload];
}
@end
