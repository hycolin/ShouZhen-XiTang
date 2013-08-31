//
//  SGBookViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGBookViewController.h"

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
    self.title = @"订票";
    
    self.bgTitleImageView.image = [[UIImage imageNamed:@"bar_b"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    self.bgTitleTopImageView.image = [[UIImage imageNamed:@"bg_title"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.dateTextField.background = [[UIImage imageNamed:@"input-box"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.nameTextField.background = [[UIImage imageNamed:@"input-box"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.phoneTextField.background = [[UIImage imageNamed:@"input-box"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    
    self.dateTextField.delegate = self;
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction)]];
}

- (void)panGestureAction
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
    [_datePickerActionSheet dismissWithClickedButtonIndex:[_datePickerActionSheet cancelButtonIndex] animated:YES];
}

- (IBAction)cancelDatePickerAction:(id)sender {
    [_datePickerActionSheet dismissWithClickedButtonIndex:[_datePickerActionSheet cancelButtonIndex] animated:YES];
}



@end
