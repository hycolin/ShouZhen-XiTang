//
//  SGAppDelegate.m
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGAppDelegate.h"
#import "YMCoverNavigationViewController.h"
#import "SGHomeViewController.h"
#import "SGMenuViewController.h"
#import "SGFakeDataHelper.h"
#import "LocationManager.h"
#import "AlixPay.h"

@implementation SGAppDelegate
{
    Reachability *internetReach;
}

+ (SGAppDelegate *)instance
{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.homeController = [[SGHomeViewController alloc] init];
    self.bookController = [[SGBookViewController alloc] init];
    self.favoriteController = [[SGFavoriteViewController alloc] init];
    self.mapController = [[SGMapViewController alloc] init];
    self.moreController = [[SGMoreViewController alloc] init];
    
    YMCoverNavigationViewController *navigationController = [[YMCoverNavigationViewController alloc] initWithRootViewController:self.homeController];    
    self.drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:navigationController
                                             leftDrawerViewController:[[SGMenuViewController alloc] init]];
    [self.drawerController setMaximumLeftDrawerWidth:240];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[LocationManager instance] stop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[LocationManager instance] start];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NetworkStatus)netStatus {
	return [internetReach currentReachabilityStatus];
}

- (BOOL)parseAlipayURL:(NSURL *)url application:(UIApplication *)application {
    if ([[url host] isEqualToString:@"safepay"]) {
        AlixPay *alixpay = [AlixPay shared];
        AlixPayResult *result = [alixpay handleOpenURL:url];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"alipayFinished" object:result];
        return YES;
    }
	
    return NO;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([self parseAlipayURL:url application:application]) {
        return YES;
    }
    return NO;
}


@end
