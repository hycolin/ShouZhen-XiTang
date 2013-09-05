//
//  SGOrderStatusViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-5.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGOrderStatusViewController.h"

@interface SGOrderStatusViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgTopImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *cofirmIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIView *alertLayout;
@property (weak, nonatomic) IBOutlet UIImageView *alertBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *alertContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;


@end

@implementation SGOrderStatusViewController

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
    self.title = @"支付成功";
    
    self.bgTopImageView.image = [[UIImage imageNamed:@"bar_b"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    self.alertBgImageView.image = [[UIImage imageNamed:@"bg_huang"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [self.bookButton setBackgroundImage:[[UIImage imageNamed:@"button_xiadan"] stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
    
    self.alertContentLabel.text = @"游玩当天凭预订成功短信，到取票点报确认码或手机号码换票入园。\n订单取消电话：0573-84560561";
    self.alertContentLabel.numberOfLines = 0;
    CGSize size = [self.alertContentLabel.text sizeWithFont:self.alertContentLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.alertContentLabel.frame), INT_MAX)];
    CGRect frame = self.alertContentLabel.frame;
    frame.size = size;
    self.alertContentLabel.frame = frame;
    
    frame = self.alertLayout.frame;
    frame.size.height = CGRectGetHeight(self.alertContentLabel.frame) + 70;
    self.alertLayout.frame = frame;
    
    self.alertBgImageView.frame = self.alertLayout.bounds;
    
    
    self.amountLabel.text = [NSString stringWithFormat:@"%g", self.amount];
    frame = self.unitLabel.frame;
    frame.origin.x = CGRectGetMinX(self.amountLabel.frame) + [self.amountLabel.text sizeWithFont:self.amountLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.amountLabel.frame), INT_MAX)].width + 5;
    self.unitLabel.frame = frame;
    
    self.navigationItem.leftBarButtonItem = nil;
}

- (IBAction)bookAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBgTopImageView:nil];
    [self setOrderNoLabel:nil];
    [self setCofirmIDLabel:nil];
    [self setAmountLabel:nil];
    [self setAlertLayout:nil];
    [self setAlertBgImageView:nil];
    [self setAlertContentLabel:nil];
    [self setBookButton:nil];
    [self setUnitLabel:nil];
    [super viewDidUnload];
}
@end
