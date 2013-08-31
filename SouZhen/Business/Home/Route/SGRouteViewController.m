//
//  SGRouteViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGRouteViewController.h"
#import "SGRouteDetailViewController.h"

@interface SGRouteViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SGRouteViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"路线";
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), 786);
}

- (IBAction)routeAction:(id)sender {
    int tag = ((UIButton *)sender).tag;
    if (tag == RouteTypeYY) {
        SGViewController *viewController = [[SGViewController alloc] init];
        viewController.title = @"夜游";
        viewController.viewBundleName = @"SGRouteNightView";
        [self.navigationController pushViewController:viewController animated:YES];        
    } else if (tag == RouteTypeYSY) {
        SGViewController *viewController = [[SGViewController alloc] init];
        viewController.title = @"影视游";
        viewController.viewBundleName = @"SGRouteYSYView";
        [self.navigationController pushViewController:viewController animated:YES];        
    } else {
        SGRouteDetailViewController *viewController = [[SGRouteDetailViewController alloc] init];
        viewController.routeType = tag;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
