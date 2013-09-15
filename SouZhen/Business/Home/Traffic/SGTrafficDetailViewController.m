//
//  SGTrafficDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGTrafficDetailViewController.h"

@interface SGTrafficDetailViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation SGTrafficDetailViewController
{
}

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
    self.scrollView.contentSize = self.contentSize;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *titleIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.titleIcon]];
    titleIconImageView.frame = CGRectMake(0, 0, 30, 30);
    [view addSubview:titleIconImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 60, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.text = self.title;
    [view addSubview:label];
    
    self.navigationItem.titleView = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
