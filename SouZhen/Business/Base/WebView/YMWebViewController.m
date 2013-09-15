//
//  NVWebViewController.m
//  NVScope
//
//  Created by Mac on 11-3-27.
//  Copyright 2011 dianping.com. All rights reserved.
//

#import "YMWebViewController.h"
#import "SGAppDelegate.h"

@implementation YMWebViewController

@synthesize webView;
@synthesize errorLabel;
@synthesize retryButton;
@synthesize titleLoadingIndicator;
@synthesize disableWebTitle;

- (void)viewDidLoad {
	[super viewDidLoad];
	if(titleLoadingIndicator) {
		UIBarButtonItem *loadingBar = [[UIBarButtonItem alloc] initWithCustomView:titleLoadingIndicator];
		self.navigationItem.rightBarButtonItem = loadingBar;
	}
//	[retryButton setAdditionStyle:NVButtonBackgroundNormal];
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods

- (BOOL)webView:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSURL *url = [request URL];
	NSString *sUrl = [url absoluteString];
	if(!([@"http" isEqual:[url scheme]] || [@"https" isEqual:[url scheme]])) {
		[[UIApplication sharedApplication] openURL:url];
		return NO;
	}
	if([@"http" isEqual:[url scheme]]
	   && ([sUrl hasPrefix:@"http://maps.google.com/"]
		   || [sUrl hasPrefix:@"http://www.youtube.com/"]
		   || [sUrl hasPrefix:@"http://phobos.apple.com/WebObjects/"]
		   || [sUrl hasPrefix:@"http://itunes.apple.com/WebObjects/"]
		   || [sUrl rangeOfString:@"&tag=external"].location != NSNotFound
		   || [sUrl rangeOfString:@"?tag=external"].location != NSNotFound)) {
		   return ![[UIApplication sharedApplication] openURL:url];
	   }
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)web {
	[titleLoadingIndicator setHidden:NO];
	[titleLoadingIndicator startAnimating];
	
	NSDate *d = [[NSDate alloc] init];
	startMillis = [d timeIntervalSince1970];
}

- (void)webViewDidFinishLoad:(UIWebView *)web {
	[webView setHidden:NO];
	[titleLoadingIndicator setHidden:YES];
	[titleLoadingIndicator stopAnimating];
	[retryButton setHidden:YES];
	[errorLabel setHidden:YES];
	
    if (!disableWebTitle) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.navigationItem.title = title;        
    }
}

- (void)webView:(UIWebView *)web didFailLoadWithError:(NSError *)error {
	if([error code] == NSURLErrorCancelled) // this error (-999) can be safely ignored
		return;
	if([[error domain] isEqual:NSURLErrorDomain]) {
		NSURL *url = [[error userInfo] objectForKey:@"NSErrorFailingURLKey"];
		retryUrl = [url copy];
		
		[webView setHidden:YES];
		[titleLoadingIndicator setHidden:YES];
		[titleLoadingIndicator stopAnimating];
		[retryButton setHidden:NO];
		[errorLabel setHidden:NO];
		
		if([[SGAppDelegate instance] netStatus] == NotReachable) {
			errorLabel.text = @"无法连接到服务，请检查网络连接是否可用";
		} else {
			errorLabel.text = @"服务暂时不可用，请稍后再试";
		}
	}
}

- (IBAction)retry:(id)sender {
	[retryButton setHidden:YES];
	[errorLabel setHidden:YES];
	
	if(retryUrl) {
		[webView loadRequest:[NSURLRequest requestWithURL:retryUrl]];
	} else {
		[webView reload];
	}
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.webView.delegate = nil;	
	self.webView = nil;
	self.errorLabel = nil;
	self.retryButton = nil;
	self.titleLoadingIndicator = nil;
	
	[super viewDidUnload];
}

- (void)dealloc {
	[self viewDidUnload];
}

@end
