//
//  SGViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SGViewController ()

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation SGViewController

- (id)init
{
    self = [super initWithNibName:@"SGViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentView.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_title-bar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setItems:[NSArray arrayWithObject:self.navigationItem]];
    
    NSString *bundleName = [self viewBundleName];
    if (bundleName.length == 0) {
        bundleName = NSStringFromClass([self class]);
    }
    if (bundleName.length > 0) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:bundleName owner:self options:nil];
        UIView *view = [views objectAtIndex:0];
        view.frame = self.contentView.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:view];
    }
}

- (void)setNavigationBarHidden:(BOOL)hidden
{
    self.navigationBar.hidden = hidden;
    if (hidden) {
        CGRect frame = self.contentView.frame;
        frame.origin.y = 0;
        frame.size.height = CGRectGetHeight(self.view.frame);
        self.contentView.frame = frame;
    } else {
        CGRect frame = self.contentView.frame;
        frame.origin.y = CGRectGetHeight(self.navigationBar.frame);
        frame.size.height = CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.navigationBar.frame);
        self.contentView.frame = frame;
    }
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:34/255.f green:34/255.f blue:34/255.f alpha:1];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.font = [UIFont boldSystemFontOfSize:20];
    label.text = title;
    self.navigationItem.titleView = label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNavigationBar:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}
@end
