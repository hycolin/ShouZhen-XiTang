//
//  SGHelpViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-14.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHelpViewController.h"
#import "SGHelpDetailViewController.h"
#import "SGHelpNetworkViewController.h"

@interface SGHelpViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *borderImageView;

@end

@implementation SGHelpViewController

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
    self.title = @"帮助";
    self.borderImageView.image = [[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];

}

- (IBAction)locateHelpAction:(id)sender {
    SGHelpDetailViewController *viewController = [[SGHelpDetailViewController alloc] init];
    viewController.contentImage = @"locatehelper";
    viewController.title = @"如何开启位置服务？";
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)wifiHelpAction:(id)sender {
    SGHelpNetworkViewController *viewController = [[SGHelpNetworkViewController alloc] init];
    viewController.title = @"如何开启网络？";
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
