//
//  SGTextViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGTextViewController.h"
#import "DrapCapTextView.h"

@interface SGTextViewController ()

@property (strong, nonatomic) IBOutlet DrapCapTextView *textView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SGTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.textView.frame;
    frame.size.height = 1000;
    self.textView.frame = frame;
    self.textView.drapCapText = [self.text substringToIndex:1];
    self.textView.text = [self.text substringFromIndex:1];
    self.textView.dropCapFontSize = 25;
    self.textView.textFontSize = 15;
    self.textView.textColor = [UIColor colorWithRed:78/255.f green:78/255.f blue:78/255.f alpha:1];
    self.textView.lineSpace = 10;
    [self.textView sizeToFit];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(320, 1000);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
