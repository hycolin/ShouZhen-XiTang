//
//  SGEmergencyPhoneViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-2.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGEmergencyPhoneViewController.h"

@interface SGEmergencyPhoneViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *borderImageView;

@end

@implementation SGEmergencyPhoneViewController
{
    NSArray *_phoneUnits;
    NSArray *_phoneNumbers;
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
    self.title = @"应急电话";
    
    /**
     接待部：0573-84567890
     市场部：0573-84564161
     旅行社：0573-84562590
     投诉电话：0573-84561501
     急救电话：0573-84564590、0573-84564290
     **/
    _phoneUnits = [NSArray arrayWithObjects:@"接待部", @"市场部", @"旅行社", @"投诉电话", @"急救电话", @"急救电话", nil];
    _phoneNumbers = [NSArray arrayWithObjects:@"0573-84567890", @"0573-84564161", @"0573-84562590", @"0573-84561501", @"0573-84564590", @"0573-84564290", nil];
    for (int i=2000; i<=2004; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:i];
        label.text = [NSString stringWithFormat:@"%@：",[_phoneUnits objectAtIndex:i-2000]];
    }
    for (int i=3000; i<=3005; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:i];
        label.text = [_phoneNumbers objectAtIndex:i-3000];
    }
    self.borderImageView.image = [[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
}

- (IBAction)action:(id)sender {
    int tag = ((UIButton *)sender).tag;

    NSString *actionTitle = [NSString stringWithFormat:@"%@：%@", [_phoneUnits objectAtIndex:tag - 1000], [_phoneNumbers objectAtIndex:tag-1000]];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打电话" otherButtonTitles:nil];
    actionSheet.tag = tag;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", [_phoneNumbers objectAtIndex:actionSheet.tag-1000]]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBorderImageView:nil];
    [super viewDidUnload];
}
@end
