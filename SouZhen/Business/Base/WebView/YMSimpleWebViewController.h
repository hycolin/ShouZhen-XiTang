
#import <UIKit/UIKit.h>
#import "YMWebViewController.h"


@interface YMSimpleWebViewController : YMWebViewController {
	NSURL *url;
	NSString *title;
	BOOL openExternal;
}
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) BOOL openExternal;

@end
