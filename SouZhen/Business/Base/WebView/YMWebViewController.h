//
//  NVWebViewController.h
//  NVScope
//
//  Created by Mac on 11-3-27.
//  Copyright 2011 dianping.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"


@interface YMWebViewController : SGViewController <UIWebViewDelegate> {
	UIWebView *webView;
	UILabel *errorLabel;
	UIButton *retryButton;
	UIActivityIndicatorView *titleLoadingIndicator;
	
	NSTimeInterval startMillis;
	NSURL	 *retryUrl;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *errorLabel;
@property (nonatomic, retain) IBOutlet UIButton *retryButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *titleLoadingIndicator;
@property (nonatomic, assign) BOOL disableWebTitle; //是否禁用网页标题，默认不禁用，即显示网页的标题

- (IBAction)retry:(id)sender;

@end
