//
//  SGOrderViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-5.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGOrderViewController.h"
#import "SGOrderStatusViewController.h"
#import "AlixPay.h"
#import "SGPayWebViewController.h"

@interface SGOrderViewController () <UITextFieldDelegate, ASIHTTPRequestDelegate>

@property (weak, atomic) IBOutlet UIImageView *bgTopImageView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@property (weak, nonatomic) IBOutlet UITextField *bookCountTextField;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIButton *aliClientPayButton;
@property (weak, nonatomic) IBOutlet UIButton *aliWebPayButton;


@end

@implementation SGOrderViewController
{
    ASIHTTPRequest *_payOrderRequest;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alipayFinished:) name:@"alipayFinished" object:nil];
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
    
    if ([[AlixPay shared] checkAvaliable]) {
        self.aliClientPayButton.selected = YES;
        self.aliWebPayButton.selected = NO;
    } else {
        self.aliClientPayButton.selected = NO;
        self.aliWebPayButton.selected = YES;
    }
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
    _payOrderRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.xitang.com.cn/dingpiao/Api.ashx?apikey=v1.00000001&method=payorder&orderid=%@&count=%d&paytype=%d", self.orderId, [self.bookCountTextField.text integerValue], self.aliClientPayButton.selected?0:1]]];
    _payOrderRequest.delegate = self;
    [_payOrderRequest startAsynchronous];
}

- (void)paySuccess
{
    }

- (void)requestStarted:(ASIHTTPRequest *)request
{
    [self showWaiting:@"正在支付..."];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self hideWaiting];
    NSDictionary *dict = [request.responseString JSONValue];
    NSInteger errorCode = [[dict objectForKey:@"errorcode"] integerValue];
    if (errorCode < 0) {
        NSString *errMsg = [dict objectForKey:@"errormsg"];
        [self showAlert:errMsg];
        return;
    }
    
    if (request == _payOrderRequest) {
        NSString *content = [dict objectForKey:@"content"];
        if (content.length == 0) {
            [self showAlert:@"服务暂时不可用"];
            return;
        }
        NSInteger type = [[dict objectForKey:@"type"] integerValue];
//        content = @"http://wappaygw.alipay.com/service/rest.htm?format=xml&partner=2088301426069753&req_data=%3Cauth_and_execute_req%3E%3Crequest_token%3E2013091476283de7af18a29ac384cecec316cca9%3C%2Frequest_token%3E%3C%2Fauth_and_execute_req%3E&sec_id=MD5&service=alipay.wap.auth.authAndExecute&sign=6f22a40e96ded846eaf97a12f8d60054&v=2.0";
//        type = 1;
//        content = @"partner=\"2088301754369172\"&seller=\"jwxu@ctrip.com\"&out_trade_no=\"201309150750130762\"&subject=\"西塘古镇景区门票\"&total_fee=\"210\"&body=\"西塘古镇景区成人票\"&notify_url=\"http://10.0.16.81/dingpiao/notify.ashx\"&sign=\"I0/jD1chxlWy7UAtW+bXCshQ17KlazNYJEt6C9xIRE/I8nv8XVm2Dem13FohXhI1j5hkl2tTv3xygBWEZ2vtliaPFLukNSnEjOimd17fAD6JX7HPHtoxtvj8VMFqm691oZiw2r1t9LIcY5ZSru8Agy9XQytcd5PYOKlu+ka0Iuk=\"&sign_type=\"RSA\"";
//        content = @"http://wappaygw.alipay.com/service/rest.htm?req_data=%3cdirect_trade_create_req%3e%3cnotify_url%3ehttp%3a%2f%2f10.0.16.81%2fdingpiao%2fnotify.ashx%3c%2fnotify_url%3e%3ccall_back_url%3ehttp%3a%2f%2f10.0.16.81%2fdingpiao%2fnotify.ashx%3c%2fcall_back_url%3e%3cseller_account_name%3ejwxu%40ctrip.com%3c%2fseller_account_name%3e%3cout_trade_no%3e201309150750130762%3c%2fout_trade_no%3e%3csubject%3e%e8%a5%bf%e5%a1%98%e5%8f%a4%e9%95%87%e6%99%af%e5%8c%ba%e9%97%a8%e7%a5%a8%3c%2fsubject%3e%3ctotal_fee%3e210%3c%2ftotal_fee%3e%3c%2fdirect_trade_create_req%3e&service=alipay.wap.trade.create.direct&sec_id=0001&partner=2088301754369172&req_id=20130922173939&sign=%22GvNWLUJYEfSJ0LbnHHBWBqGzWYLH%2ffzGYn0rTDqqhzjeUjclOKGJFQXlMZ9F6WMDAc8Re4ic44JRGdCk23DgsJYS2YE6BkjQtwVKndhn8WgzrYuxInP%2fUKy5Vt8qowW2lSh8swmVHFdXp8jhT8N5O42iplsV5ZaEs7T1UwTmjeA%3d%22&format=XML&v=2.0";
        if (type == 0) {
            [[AlixPay shared] pay:content applicationScheme:@"xitang"];
        } else {
            SGPayWebViewController *viewController = [[SGPayWebViewController alloc] init];
            viewController.url = [NSURL URLWithString:content];
            viewController.amount = [_amountLabel.text doubleValue];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideWaiting];
}


- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}


- (IBAction)selectPayTypeAction:(id)sender {
    if (sender == self.aliClientPayButton) {
        if (![[AlixPay shared] checkAvaliable]) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝的客户端，或版本太低。1.建议您点击返回，选择支付宝网页支付！2.下载或更新支付宝客户端，可能需要较长时间。"
                                                                delegate:self
                                                       cancelButtonTitle:@"返回"
                                                       otherButtonTitles:@"安装", nil];
            [alertView setTag:123];
            [alertView show];
            return;
        }
    }
    self.aliClientPayButton.selected = (self.aliClientPayButton == sender);
    self.aliWebPayButton.selected = (self.aliWebPayButton == sender);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            NSString * URLString = @"http://itunes.apple.com/cn/app/id333206289?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
        }
	}
}

- (void)alipayFinished:(NSNotification *)notification
{
    [self hideWaiting];
    AlixPayResult *result = notification.object;
    if (9000 == result.statusCode) { //支付成功
        SGOrderStatusViewController *viewController = [[SGOrderStatusViewController alloc] init];
        viewController.amount = [self.amountLabel.text doubleValue];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:result.statusMessage
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
        [alertView show];
    }
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
