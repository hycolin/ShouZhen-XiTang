//
//  SGOrderStatusViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-5.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGOrderStatusViewController.h"

@interface SGOrderStatusViewController () <ASIHTTPRequestDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgTopImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *cofirmIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIView *alertLayout;
@property (weak, nonatomic) IBOutlet UIImageView *alertBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *alertContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (weak, nonatomic) IBOutlet UIView *alertView;

@end

@implementation SGOrderStatusViewController
{
    ASIHTTPRequest *_getOrderStatusRequest;
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
    self.title = @"支付成功";

    [self requestOrderStatus];
    
    self.bgTopImageView.image = [[UIImage imageNamed:@"bar_b"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    self.alertBgImageView.image = [[UIImage imageNamed:@"bg_huang"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [self.bookButton setBackgroundImage:[[UIImage imageNamed:@"button_xiadan"] stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)updateOrderStatusUI:(NSString *)confirmId amount:(double)amount alert:(NSString *)alert
{
    if (alert.length == 0) {
        alert = @"游玩当天凭预订成功短信，到取票点报确认码或手机号码换票入园。\n订单取消电话：0573-84560561";
    }
    self.alertContentLabel.text = alert;
    self.alertContentLabel.numberOfLines = 0;
    CGSize size = [self.alertContentLabel.text sgSizeWithFont:self.alertContentLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.alertContentLabel.frame), INT_MAX)];
    CGRect frame = self.alertContentLabel.frame;
    frame.size = size;
    self.alertContentLabel.frame = frame;
    
    frame = self.alertLayout.frame;
    frame.size.height = CGRectGetHeight(self.alertContentLabel.frame) + 70;
    self.alertLayout.frame = frame;
    
    self.alertBgImageView.frame = self.alertLayout.bounds;
    
    
    self.orderNoLabel.text = self.orderId;
    self.cofirmIDLabel.text = confirmId;
    
    self.amountLabel.text = [NSString stringWithFormat:@"%g", amount];
    frame = self.unitLabel.frame;
    frame.origin.x = CGRectGetMinX(self.amountLabel.frame) + [self.amountLabel.text sgSizeWithFont:self.amountLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.amountLabel.frame), INT_MAX)].width + 5;
    self.unitLabel.frame = frame;

}

- (void)requestOrderStatus
{
    _getOrderStatusRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.xitang.com.cn/dingpiao/Api.ashx?apikey=v1.00000001&method=getorderstatus&orderid=%@", self.orderId]]];
    _getOrderStatusRequest.delegate = self;
    [_getOrderStatusRequest startAsynchronous];
}

- (void)requestStarted:(ASIHTTPRequest *)request
{
    self.alertView.hidden = NO;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    dlog(@"url: %@", request.url);
    NSDictionary *dict = [request.responseString JSONValue];
    NSInteger errorCode = [[dict objectForKey:@"errorcode"] integerValue];
    if (errorCode < 0) {
//        NSString *errMsg = [dict objectForKey:@"errormsg"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"获取订单状态失败，点击确定后重试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1000;
        [alertView show];
        return;
    }
    self.alertView.hidden = YES;
    NSNumber *amount = [dict objectForKey:@"amount"];
    NSString *confirmId = [dict objectForKey:@"confirmid"];
    NSString *alert = [dict objectForKey:@"alert"];
    [self updateOrderStatusUI:confirmId amount:[amount doubleValue] alert:alert];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"获取订单状态失败，点击确定后重试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 1000;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            [self requestOrderStatus];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }        
    }
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
