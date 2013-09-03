//
//  SGFoodDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-1.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGFoodDetailViewController.h"
#import "SGFavoriteHelper.h"

@interface SGFoodDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet SGFoodPhotoCell *photoCell;
@property (weak, nonatomic) IBOutlet SGFoodInfoCell *introCell;
@property (weak, nonatomic) IBOutlet SGFoodInfoCell *materialCell;
@property (weak, nonatomic) IBOutlet SGFoodInfoCell *cookbookCell;

@end

@implementation SGFoodDetailViewController
{
    NSArray *_cellList;
    UIButton *_favoButton;
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
    self.title = self.food.name;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;

    [self.photoCell showPhoto:self.food.imageUrl];
    self.photoCell.foodDetailViewController = self;
    [self.introCell showInfo:self.food.intro mark:@"简介"];
    self.introCell.foodDetailViewController = self;
    [self.materialCell showInfo:self.food.material mark:@"原料"];
    self.materialCell.foodDetailViewController = self;
    [self.cookbookCell showInfo:self.food.cookbook mark:@"制作方法"];
    self.cookbookCell.foodDetailViewController = self;
    
    _cellList = [NSArray arrayWithObjects:self.photoCell, self.introCell, self.materialCell, self.cookbookCell, nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    _favoButton = button;
    [self updateFavoriteState];
}

- (void)updateFavoriteState
{
    if ([[SGFavoriteHelper instance] isFavorite:self.food.uid]) {
        [_favoButton setImage:[UIImage imageNamed:@"icon_collection_d"] forState:UIControlStateNormal];
    } else {
        [_favoButton setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    }
}

- (void)favoriteAction
{
    if ([[SGFavoriteHelper instance] isFavorite:self.food.uid]) {
        [[SGFavoriteHelper instance] delFavorite:self.food.uid type:FavoriteTypeFood];
        [self showSplash:@"删除收藏成功"];
    } else {
        [[SGFavoriteHelper instance] addFavoriteWithFood:self.food];
        [self showSplash:@"添加收藏成功"];
    }
    [self updateFavoriteState];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_cellList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_cellList objectAtIndex:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_cellList objectAtIndex:indexPath.section];
    return CGRectGetHeight(cell.frame);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (void)updateUI
{
    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:NO];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled:animationsEnabled];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end

@implementation SGFoodPhotoCell

- (void)showPhoto:(NSString *)photoName
{
    self.photoView.image = [UIImage imageNamed:photoName];
}

@end

@implementation SGFoodInfoCell
{
    BOOL _fold;
    NSString *_info;
}

- (void)updateUI
{
    if (_fold) {
        CGRect frame = self.frame;
        frame.size.height = 80;
        self.frame = frame;
    } else {
        CGRect frame = self.frame;
        frame.size.height = 40 + ceilf([_info sizeWithFont:self.infoLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.infoLabel.frame), 9999)].height);
        if (frame.size.height < 80) {
            frame.size.height = 80;
        }
        self.frame = frame;
    }
    self.foldButton.hidden = (40 + ceilf([_info sizeWithFont:self.infoLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.infoLabel.frame), 9999)].height)) <= 80;
    if (!self.foldButton.hidden) {
        CGRect frame = self.foldButton.frame;
        frame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(self.foldButton.frame) - 5;
        self.foldButton.frame = frame;
        if (!_fold) {
            self.foldButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                                M_PI);
        } else {
            self.foldButton.transform = CGAffineTransformIdentity;
        }
    }
    [self.foodDetailViewController updateUI];
}

- (IBAction)foldAction:(id)sender {
    _fold = !_fold;
    [self updateUI];
}

- (void)awakeFromNib
{
    [self.infoButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    [self.infoButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateHighlighted];
    _fold = YES;
}

- (void)showInfo:(NSString *)info mark:(NSString *)mark
{
    _info = info;
    self.markLabel.text = mark;
    self.infoLabel.text = info;
    
    [self updateUI];
}

@end
