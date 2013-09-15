//
//  SGMoreViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGMoreViewController.h"
#import "SGAboutusViewController.h"
#import "SGEmergencyPhoneViewController.h"
#import "SGHelpViewController.h"

@interface SGMoreViewController ()

@property (weak, nonatomic) IBOutlet UIButton *boxButton;
@property (weak, nonatomic) IBOutlet UIButton *foldbutton;
@property (weak, nonatomic) IBOutlet UIButton *aboutusButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *aboutusLayout;
@property (weak, nonatomic) IBOutlet UITableViewCell *boxLayout;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation SGMoreViewController
{
    BOOL _foldBox;
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
    self.title = @"更多";
    
    self.versionLabel.text = [NSString stringWithFormat:@"版本号：v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    
    [self.boxButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    [self.boxButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateHighlighted];

    [self.aboutusButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    
    self.boxLayout.clipsToBounds = YES;
    
    _foldBox = YES;
    [self updateBoxUI];
}

- (void)updateBoxUI
{
    if (_foldBox) {
        CGRect frame = self.boxLayout.frame;
        frame.size.height = 43;
        self.boxLayout.frame = frame;
    } else {
        CGRect frame = self.boxLayout.frame;
        frame.size.height = 127;
        self.boxLayout.frame = frame;
    }
    CGRect frame = self.aboutusLayout.frame;
    frame.origin.y = CGRectGetMaxY(self.boxLayout.frame) + 23;
    self.aboutusLayout.frame = frame;
    
    if (!_foldBox) {
        self.foldbutton.transform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                            M_PI);
    } else {
        self.foldbutton.transform = CGAffineTransformIdentity;
    }
}

- (IBAction)foldAction:(id)sender {
    _foldBox = !_foldBox;
    [self updateBoxUI];
}

- (IBAction)aboutusAction:(id)sender {
    SGAboutusViewController *viewController = [[SGAboutusViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)phoneAction:(id)sender {
    SGEmergencyPhoneViewController *viewController = [[SGEmergencyPhoneViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)helpAction:(id)sender {
    SGHelpViewController *viewController = [[SGHelpViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBoxButton:nil];
    [self setFoldbutton:nil];
    [self setAboutusButton:nil];
    [self setAboutusLayout:nil];
    [self setBoxLayout:nil];
    [self setVersionLabel:nil];
    [super viewDidUnload];
}
@end
