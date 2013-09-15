
#import "YMSimpleWebViewController.h"


@implementation YMSimpleWebViewController

@synthesize url;
@synthesize title;
@synthesize openExternal;

- (NSString *)viewBundleName
{
    return @"SimpleWebView";
}

- (BOOL)webView:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if(self.openExternal) {
		if([[request URL] isEqual:url])
			return YES;
		
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	} else {
		return [super webView:web shouldStartLoadWithRequest:request navigationType:navigationType];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	if([title length] > 0) {
		self.navigationItem.title = title;
	}
	[webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)dealloc {
}

@end
