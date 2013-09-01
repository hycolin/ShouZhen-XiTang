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
    
    self.bannerScrollview.contentSize = CGSizeMake(1600, CGRectGetHeight(self.bannerScrollview.frame));
    self.bannerScrollview.delegate = self;
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
//            SGRouteViewController *viewController = [[SGRouteViewController alloc] init];
//            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case HomeIndexNews: //资讯
        {
//            SGRouteViewController *viewController = [[SGRouteViewController alloc] init];
//            [self.navigationController pushViewController:viewController animated:YES];
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
    [super viewDidUnload];
}
@end
