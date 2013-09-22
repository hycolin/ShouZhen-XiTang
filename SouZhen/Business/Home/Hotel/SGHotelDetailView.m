//
//  SGHotelDetailView.m
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHotelDetailView.h"
#import "SGMapViewController.h"
#import "SGHotelDetailViewController.h"

@class SGHotelDetailCell;
@class SGHotelAddressCell;
@class SGHotelServiceCell;
@class SGHotelWayCell;

@interface SGHotelDetailView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) IBOutlet SGHotelPhotoCell *photoCell;
@property (strong, nonatomic) IBOutlet SGHotelDetailCell *detailCell;
@property (strong, nonatomic) IBOutlet SGHotelAddressCell *addressCell;
@property (strong, nonatomic) IBOutlet SGHotelServiceCell *serviceCell;
@property (strong, nonatomic) IBOutlet SGHotelWayCell *wayCell;


@end

@implementation SGHotelDetailView
{
    SGHotelData *_hotelData;
    NSMutableArray *_cellList;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
    
    self.photoCell.parentView = self;
    self.detailCell.parentView = self;
    self.addressCell.parentView = self;
    self.serviceCell.parentView = self;
    self.wayCell.parentView = self;
    
    _cellList = [NSMutableArray arrayWithCapacity:5];
}

- (void)showData:(SGHotelData *)data
{
    _hotelData = data;
    self.photoCell.hotelData = data;
    self.detailCell.hotelData = data;
    self.addressCell.hotelData = data;
    self.serviceCell.hotelData = data;
    self.wayCell.hotelData = data;
    
    [_cellList removeAllObjects];
    
    if (_hotelData.imageUrl.length > 0) {
        [_cellList addObject:self.photoCell];
    }
    if (_hotelData.intro.length > 0) {
        [_cellList addObject:self.detailCell];
    }
    if (_hotelData.address.length > 0) {
        [_cellList addObject:self.addressCell];
    }
    if (_hotelData.tag.length > 0) {
        [_cellList addObject:self.serviceCell];
    }
    if (_hotelData.way.length > 0) {
        [_cellList addObject:self.wayCell];
    }
    [self.tableView reloadData];
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

- (void)openAddress
{
    SGMapViewController *mapViewController = [[SGMapViewController alloc] init];
    mapViewController.mapType = MapTypeSingle;
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:1];
    [list addObject:[[SGAnnotation alloc] initWithId:_hotelData.uid
                                                 lat:_hotelData.lat
                                                 lng:_hotelData.lng
                                             address:_hotelData.address
                                               title:_hotelData.name
                                            subTitle:_hotelData.intro
                                           leftImage:_hotelData.imageUrl
                                                type:AnnotationTypeHotel]];
    [mapViewController setAnnotations:list];
    [self.hotelDetailController.navigationController pushViewController:mapViewController animated:YES];
}

@end


@implementation SGHotelPhotoCell

- (void)setHotelData:(SGHotelData *)hotelData
{
    self.photoImageView.image = [UIImage imageNamed:hotelData.imageUrl];
}

@end

@implementation SGHotelDetailCell
{
    BOOL _fold;
}

- (void)awakeFromNib
{
    self.labelMark.layer.masksToBounds = YES;
    self.labelMark.layer.cornerRadius = 3;
    _fold = YES;
}

- (void)setHotelData:(SGHotelData *)hotelData
{
    _hotelData = hotelData;
    self.detailLabel.text = _hotelData.intro;
    [self updateUI];
}

- (void)updateUI
{
    if (_fold) {
        CGRect frame = self.detailLabel.frame;
        frame.size.height = 58;
        self.detailLabel.frame = frame;
    } else {
        CGRect frame = self.detailLabel.frame;
        frame.size.height = ceilf([self.hotelData.intro sgSizeWithFont:self.detailLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.detailLabel.frame), 9999)].height);
        self.detailLabel.frame = frame;
    }
    
    CGRect frame = self.frame;
    frame.size.height = 27 + CGRectGetHeight(self.detailLabel.frame);
    self.frame = frame;
    
    if (!_fold) {
        self.foldButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                            M_PI);
    } else {
        self.foldButton.transform = CGAffineTransformIdentity;
    }

    
    [self.parentView updateUI];
}

- (IBAction)foldAction:(id)sender {
    _fold = !_fold;
    [self updateUI];
}

@end


@implementation SGHotelAddressCell

- (void)awakeFromNib
{
    [self.addressButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    [self.addressButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateHighlighted];
}

- (void)setHotelData:(SGHotelData *)hotelData
{
    self.addressLabel.text = hotelData.address;
}

- (IBAction)addressAction:(id)sender {
    [self.parentView openAddress];
}

@end


@implementation SGHotelServiceCell
{
    BOOL _fold;
    NSArray *_services;
}

- (void)awakeFromNib
{
    [self.serviceButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    [self.serviceButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateHighlighted];

    _fold = YES;
    self.clipsToBounds = YES;
}

- (void)setHotelData:(SGHotelData *)hotelData
{
    _hotelData = hotelData;
    int startX = 15;
    int startY = 50;
    NSString *tag = hotelData.tag;
    _services = [tag componentsSeparatedByString:@","];
    for (int i=0; i<[_services count]; i++) {
        NSString *serviceTag = _services[i];
    
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:serviceTag]];
        imageView.frame = CGRectMake(startX + 23, startY, 24, 24);
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY + 30, 70, 15)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:136/255.f green:136/255.f blue:136/255.f alpha:1];
        label.text = serviceTag;
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:label];
        
        startX += 72;
        
        if (i != 0 && i % 3 == 0) {
            startX = 15;
            startY += 50;
        }
    }
}

- (void)updateUI
{
    if (_fold) {
        CGRect frame = self.frame;
        frame.size.height = 50;
        self.frame = frame;
    } else {
        CGRect frame = self.frame;
        frame.size.height = 50 + 50 * ceilf([_services count] / 4.f);
        self.frame = frame;
    }
    if (!_fold) {
        self.foldButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                            M_PI);
    } else {
        self.foldButton.transform = CGAffineTransformIdentity;
    }
    [self.parentView updateUI];
}

- (IBAction)foldAction:(id)sender {
    _fold = !_fold;
    [self updateUI];
}

@end

@implementation SGHotelWayCell
{
    BOOL _fold;
    float _textHeight;
    UILabel *_textLabel;
}

- (void)awakeFromNib
{
    [self.wayButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateNormal];
    [self.wayButton setBackgroundImage:[[UIImage imageNamed:@"bg_bar.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25] forState:UIControlStateHighlighted];

    self.clipsToBounds = YES;
    _fold = YES;
}

- (void)setHotelData:(SGHotelData *)hotelData
{
    _hotelData = hotelData;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    _textHeight = ceilf([self.hotelData.way sgSizeWithFont:font constrainedToSize:CGSizeMake(280, 9999)].height);
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, _textHeight)];
    _textLabel.numberOfLines = 0;
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textColor = [UIColor colorWithRed:136/255.f green:136/255.f blue:136/255.f alpha:1];
    _textLabel.text = self.hotelData.way;
    _textLabel.font = font;
    [self addSubview:_textLabel];
    _textLabel.hidden = _fold;
}

- (void)updateUI
{
    if (_fold) {
        CGRect frame = self.frame;
        frame.size.height = 50;
        self.frame = frame;
    } else {
        CGRect frame = self.frame;
        frame.size.height = 50 + _textHeight;
        self.frame = frame;
    }
    if (!_fold) {
        self.foldButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                            M_PI);
    } else {
        self.foldButton.transform = CGAffineTransformIdentity;
    }
    _textLabel.hidden = _fold;
    [self.parentView updateUI];
}

- (IBAction)foldAction:(id)sender {
    _fold = !_fold;
    [self updateUI];
}

@end