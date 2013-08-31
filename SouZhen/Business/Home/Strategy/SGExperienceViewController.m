//
//  SGExperienceViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGExperienceViewController.h"

typedef enum {
    ExperienceTypeRoute = 1000,
    ExperienceTypeEat,
    ExperienceTypeLive,
    ExperienceTypeGou,
} ExperienceType;

@interface SGExperienceViewController ()


@end

@implementation SGExperienceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)viewBundleName
{
    return @"SGExperienceView";
}

- (IBAction)action:(id)sender {
    SGViewController *viewController = [[SGViewController alloc] init];
    viewController.title = @"我的西塘之旅";
    int tag = ((UIButton *)sender).tag;
    int scrollHeight = 0;
    switch (tag) {
        case ExperienceTypeRoute:
            viewController.viewBundleName = @"SGExperienceRouteViewController";
            scrollHeight = 1626;
            break;
        case ExperienceTypeEat:
            viewController.viewBundleName = @"SGExperienceEatViewController";
            scrollHeight = 747;
            break;
        case ExperienceTypeLive:
            viewController.viewBundleName = @"SGExperienceLiveViewController";
            scrollHeight = 982;
            break;
        case ExperienceTypeGou:
            viewController.viewBundleName = @"SGExperienceGouViewController";
            scrollHeight = 303;
            break;
        default:
            break;
    }
    [viewController view];
    [((UIScrollView *)[viewController.contentView subviews][0]) setContentSize:CGSizeMake(320, scrollHeight)];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的西塘之旅";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
