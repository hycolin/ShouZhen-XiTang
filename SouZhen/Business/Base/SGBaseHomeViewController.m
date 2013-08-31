//
//  SGBaseHomeViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGBaseHomeViewController.h"
#import "SGAppDelegate.h"

@interface SGBaseHomeViewController ()

@end

@implementation SGBaseHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *menuImage = [UIImage imageNamed:@"icon_menu"];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 0, 50, 44);
    [menuButton setImage:menuImage forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
}

- (void)menuAction
{
    if ([[SGAppDelegate instance].drawerController openSide] == MMDrawerSideNone) {
        [[SGAppDelegate instance].drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    } else {
        [[SGAppDelegate instance].drawerController closeDrawerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
