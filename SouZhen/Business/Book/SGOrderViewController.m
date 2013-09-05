//
//  SGOrderViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-5.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGOrderViewController.h"
#import "SGOrderStatusViewController.h"

@interface SGOrderViewController () <UITextFieldDelegate>

@property (weak, atomic) IBOutlet UIImageView *bgTopImageView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@property (weak, nonatomic) IBOutlet UITextField *bookCountTextField;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIButton *aliClientPayButton;
@property (weak, nonatomic) IBOutlet UIButton *aliWebPayButton;


@end

@implementation SGOrderViewController

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
    self.title = @"订单支付";
    self.bgTopImageView.image = [[UIImage imageNamed:@"bar_b"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.bookCountTextField.background = [[UIImage imageNamed:@"input-box"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.bookCountTextField.delegate = self;
    
    [self.aliClientPayButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.aliWebPayButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    
    UIImage *orderImage = [UIImage imageNamed:@"button_xiadan.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 32);
    [button setBackgroundImage:orderImage forState:UIControlStateNormal];
    [button setTitle:@"支付" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [button addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    self.priceLabel.text = [NSString stringWithFormat:@"%g", self.price];
    self.discountLabel.text = [NSString stringWithFormat:@"%g", self.discount];
    
    [self changeBookCount:1];
    self.bookCountTextField.text = [NSString stringWithFormat:@"%d", 1];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)]];
}

- (void)tapGestureAction
{
    [self.bookCountTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = textField.text;
    [self changeBookCount:[[text stringByReplacingCharactersInRange:range withString:string] integerValue]];
    return YES;
}

- (void)changeBookCount:(NSInteger)count
{
    self.amountLabel.text = [NSString stringWithFormat:@"%g", self.discount * count];
}

- (void)payAction
{
    [self.bookCountTextField resignFirstResponder];
    int bookCount = self.bookCountTextField.text.integerValue;
    if (bookCount <= 0) {
        [self showAlert:@"您还未指定预订数目"];
        return;
    }
    [self showWaiting:@"正在支付..."];
    [self performSelector:@selector(paySuccess) withObject:nil afterDelay:1];
}

- (void)paySuccess
{
    [self hideWaiting];
    SGOrderStatusViewController *viewController = [[SGOrderStatusViewController alloc] init];
    viewController.amount = [self.amountLabel.text doubleValue];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}


- (IBAction)selectPayTypeAction:(id)sender {
    self.aliClientPayButton.selected = (self.aliClientPayButton == sender);
    self.aliWebPayButton.selected = (self.aliWebPayButton == sender);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPriceLabel:nil];
    [self setDiscountLabel:nil];
    [self setBookCountTextField:nil];
    [self setAmountLabel:nil];
    [self setAliClientPayButton:nil];
    [self setAliWebPayButton:nil];
    [super viewDidUnload];
}
- (IBAction)aliWebPayButton:(id)sender {
}
@end
