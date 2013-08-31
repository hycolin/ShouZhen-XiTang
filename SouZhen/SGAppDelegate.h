//
//  SGAppDelegate.h
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "SGHomeViewController.h"
#import "SGBookViewController.h"
#import "SGFavoriteViewController.h"
#import "SGMapViewController.h"
#import "SGMoreViewController.h"

@interface SGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MMDrawerController * drawerController;
@property (nonatomic, strong) SGHomeViewController *homeController;
@property (nonatomic, strong) SGBookViewController *bookController;
@property (nonatomic, strong) SGFavoriteViewController *favoriteController;
@property (nonatomic, strong) SGMapViewController *mapController;
@property (nonatomic, strong) SGMoreViewController *moreController;

+ (SGAppDelegate *)instance;

@end
