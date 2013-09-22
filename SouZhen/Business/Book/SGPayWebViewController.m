//
//  SGPayWebViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-14.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGPayWebViewController.h"
#import "SGOrderStatusViewController.h"

@interface SGPayWebViewController ()

@end

@implementation SGPayWebViewController

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
	// Do any additional setup after loading the view.
}

- (BOOL)webView:(UIWebView *)webView_ shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestUrl = [[request URL] absoluteString];
    dlog(@"pay url:%@",requestUrl);
    if ([requestUrl hasPrefix:@"http://www.xitang.com.cn/dingpiao"]) {
        SGOrderStatusViewController *viewController = [[SGOrderStatusViewController alloc] init];
        viewController.amount = self.amount;
        [self.navigationController pushViewController:viewController animated:YES];
        return NO;
    }
    return [super webView:webView_ shouldStartLoadWithRequest:request navigationType:navigationType];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
