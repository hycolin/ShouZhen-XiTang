//
//  SGStrategyViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-27.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGStrategyViewController.h"
#import "SGExperienceViewController.h"

typedef enum
{
    StrategyTypeReadme,
    StrategyTypeExperience
} StrategyType;
@interface SGStrategyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *readmeButton;
@property (weak, nonatomic) IBOutlet UIButton *experienceButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SGStrategyViewController
{
    NSArray *_readmeList;
    NSArray *_experienceList;
    StrategyType _type;
}

- (id)init
{
    self = [super init];
    if (self) {
        _readmeList = [NSArray arrayWithObjects:@"夜游须知", @"景区门票", nil];
        _experienceList = [NSArray arrayWithObjects:@"我的西塘之旅", nil];;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"攻略";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    
    [self.readmeButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
    [self.experienceButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventAllEvents];
}

- (IBAction)switchButtonAction:(id)sender {
    self.readmeButton.selected = (self.readmeButton == sender);
    self.experienceButton.selected = (self.experienceButton == sender);
    _type = (self.readmeButton == sender)?StrategyTypeReadme:StrategyTypeExperience;
    [self.tableView reloadData];
}

- (void)action:(id)sender
{
    UIButton *button = sender;
    button.highlighted = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == StrategyTypeReadme) {
        return [_readmeList count];
    } else {
        return [_experienceList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"StrategyCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StrategyCell"];
        cell.frame = CGRectMake(0, 0, 320, 50);
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor colorWithRed:34/255.f green:34/255.f blue:34/255.f alpha:1];
        cell.textLabel.textAlignment = UITextAlignmentLeft;

        UIImageView *seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(cell.bounds)-1, CGRectGetWidth(cell
                                                                                                                                    .bounds), 1)];
        seperateLine.image = [UIImage imageNamed:@"bg_tableviewline.png"];
        [cell addSubview:seperateLine];
    }
    if (_type == StrategyTypeReadme) {
        cell.textLabel.text = [_readmeList objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [_experienceList objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_type == StrategyTypeReadme) {
        if (indexPath.row == 0) {
            SGViewController *viewController = [[SGViewController alloc] init];
            viewController.viewBundleName = @"SGTravellGuidelineViewController";
            viewController.title = @"夜游须知";
            [self.navigationController pushViewController:viewController animated:YES];
        } else {
            SGViewController *viewController = [[SGViewController alloc] init];
            viewController.viewBundleName = @"SGSceneryPriceViewController";
            viewController.title = @"景区门票";
            [viewController view];
            UIScrollView *scrollView = (UIScrollView *)[viewController.contentView subviews][0];
            scrollView.contentSize = CGSizeMake(320, 664);
            [self.navigationController pushViewController:viewController animated:YES];
        }
    } else {
        if (indexPath.row == 0) {
            SGExperienceViewController *viewController = [[SGExperienceViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setReadmeButton:nil];
    [self setExperienceButton:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
