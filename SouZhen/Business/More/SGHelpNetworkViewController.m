//
//  SGHelpNetworkViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-14.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHelpNetworkViewController.h"

@interface SGHelpNetworkViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;


@end

@implementation SGHelpNetworkViewController

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
	[self.button1 addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.button2 addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    
    [self showWifiHelp];
}

- (NSString *)viewBundleName
{
    return @"HelpNetworkView";
}

- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}

- (void)showWifiHelp
{
    self.contentImageView.image = [UIImage imageNamed:@"wifihelper.png"];
    CGRect frame = self.contentImageView.frame;
    frame.size.height = self.contentImageView.image.size.height/2;
    self.contentImageView.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(320, CGRectGetHeight(self.contentImageView.frame) + 20);
}

- (void)showGprsHelp
{
    self.contentImageView.image = [UIImage imageNamed:@"gprshelper.png"];
    CGRect frame = self.contentImageView.frame;
    frame.size.height = self.contentImageView.image.size.height/2;
    self.contentImageView.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(320, CGRectGetHeight(self.contentImageView.frame) + 20);
}

- (IBAction)segmentedAction:(id)sender {
    self.button1.selected = (self.button1 == sender);
    self.button2.selected = (self.button2 == sender);
    
    if (self.button1.selected) {
        [self showWifiHelp];
    } else {
        [self showGprsHelp];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
