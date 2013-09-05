//
//  SGBookViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGBookViewController.h"
#import "SGOrderViewController.h"

@interface SGBookViewController () <UITextFieldDelegate>

@property (weak, atomic) IBOutlet UIImageView *bgTitleImageView;
@property (weak, atomic) IBOutlet UIImageView *bgTitleTopImageView;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (strong, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)doneDatePickerAction:(id)sender;

@end

@implementation SGBookViewController
{
    UIActionSheet *_datePickerActionSheet;
    NSDate *_bookDate;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)registerKeywordNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keywordWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keywordWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeywordNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keywordWillShow:(NSNotification *)no
{
    NSDictionary *userInfo = [no userInfo];
	CGRect keyboardFrame;
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
	UIViewAnimationCurve curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
	NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:curve];
	[UIView setAnimationDuration:duration];
	self.view.transform = CGAffineTransformMakeTranslation(0, -100);
	[UIView commitAnimations];
}

- (void)keywordWillHide:(NSNotification *)no
{
    NSDictionary *userInfo = [no userInfo];
	CGRect keyboardFrame;
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
	UIViewAnimationCurve curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
	NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:curve];
	[UIView setAnimationDuration:duration];
	self.view.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订票";
    
    self.bgTitleImageView.image = [[UIImage imageNamed:@"bar_b"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    self.bgTitleTopImageView.image = [[UIImage imageNamed:@"bg_title"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.dateTextField.background = [[UIImage imageNamed:@"input-box"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.nameTextField.background = [[UIImage imageNamed:@"input-box"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.phoneTextField.background = [[UIImage imageNamed:@"input-box"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    
    self.dateTextField.delegate = self;
    
    UIImage *orderImage = [UIImage imageNamed:@"button_xiadan.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 32);
    [button setBackgroundImage:orderImage forState:UIControlStateNormal];
    [button setTitle:@"下单" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [button addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self removeKeywordNotification];
    [self registerKeywordNotification];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeKeywordNotification];
}

- (void)orderAction
{
    if (_bookDate == nil) {
        [self showAlert:@"您还未选择预订日期"];
        return;
    }
    NSString *name = self.nameTextField.text;
    if (name.length == 0) {
        [self showAlert:@"您还未输入取票人姓名"];
        return;
    }
    NSString *phone = self.phoneTextField.text;
    if (phone.length < 11) {
        if (phone.length == 0) {
            [self showAlert:@"您还未输入手机号码"];
        } else if (phone.length != 11) {
            [self showAlert:@"您输入11位手机号码"];
        }
        return;
    }
    SGOrderViewController *viewController = [[SGOrderViewController alloc] init];
    viewController.bookDate = _bookDate;
    viewController.name = name;
    viewController.phone = phone;
    viewController.price = 100;
    viewController.discount = 70;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)tapGestureAction
{
    [self.dateTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.dateTextField) {
        _datePickerActionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        [_datePickerActionSheet insertSubview:self.datePickerView atIndex:0];
        [_datePickerActionSheet showInView:[self view]];
        
        self.datePickerView.frame = _datePickerActionSheet.bounds;
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDateTextField:nil];
    [self setNameTextField:nil];
    [self setPhoneTextField:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
}

- (IBAction)doneDatePickerAction:(id)sender {
    NSDate *date = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    self.dateTextField.text = [formatter stringFromDate:date];
    _bookDate = date;
    [_datePickerActionSheet dismissWithClickedButtonIndex:[_datePickerActionSheet cancelButtonIndex] animated:YES];
}

- (IBAction)cancelDatePickerAction:(id)sender {
    [_datePickerActionSheet dismissWithClickedButtonIndex:[_datePickerActionSheet cancelButtonIndex] animated:YES];
}



@end
