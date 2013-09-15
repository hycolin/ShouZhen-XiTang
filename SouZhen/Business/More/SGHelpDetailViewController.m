//
//  SGHelpDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-14.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHelpDetailViewController.h"

@interface SGHelpDetailViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;


@end

@implementation SGHelpDetailViewController

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
    self.contentImageView.image = [UIImage imageNamed:self.contentImage];
    CGRect frame = self.contentImageView.frame;
    frame.size.height = self.contentImageView.image.size.height/2;
    self.contentImageView.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(320, CGRectGetHeight(self.contentImageView.frame));
}

- (NSString *)viewBundleName
{
    return @"HelpDetailView";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
