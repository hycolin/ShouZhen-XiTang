//
//  SGAboutusViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-2.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGAboutusViewController.h"

@interface SGAboutusViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation SGAboutusViewController

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
    self.title = @"关于我们";
    self.scrollView.contentSize = CGSizeMake(320, 620);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
