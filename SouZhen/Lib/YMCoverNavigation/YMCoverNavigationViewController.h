//
//  YMNavigationViewController.h
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMCoverNavigationViewController : UIViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;

@end
