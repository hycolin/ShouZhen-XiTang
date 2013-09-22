//
//  SGTrafficDriveDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-14.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGTrafficDriveDetailViewController.h"

@interface SGTrafficDriveDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (weak, nonatomic) IBOutlet UIView *contentLayout;

@property (strong, nonatomic) IBOutlet UIScrollView *driveView1;
@property (strong, nonatomic) IBOutlet UIScrollView *driveView2;
@property (strong, nonatomic) IBOutlet UIScrollView *driveView3;


@end

@implementation SGTrafficDriveDetailViewController

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
    [self.button3 addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    
    [self.contentLayout addSubview:self.driveView1];
    
    self.driveView1.contentSize = CGSizeMake(320, 1320);
    self.driveView2.contentSize = CGSizeMake(320, 1300);
    self.driveView3.contentSize = CGSizeMake(320, 990);
}

- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}

- (IBAction)segmentedAction:(id)sender {
    self.button1.selected = (self.button1 == sender);
    self.button2.selected = (self.button2 == sender);
    self.button3.selected = (self.button3 == sender);
    
    for (UIView *view in [self.contentLayout subviews]) {
        [view removeFromSuperview];
    }
    if (self.button1.selected) {
        self.driveView1.frame = self.contentLayout.bounds;
        [self.contentLayout addSubview:self.driveView1];
    } else if (self.button2.selected) {
        self.driveView2.frame = self.contentLayout.bounds;
        [self.contentLayout addSubview:self.driveView2];
    } else {
        self.driveView3.frame = self.contentLayout.bounds;
        [self.contentLayout addSubview:self.driveView3];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
