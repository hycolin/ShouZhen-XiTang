//
//  SGRouteCell.m
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGRouteCell.h"

@interface SGRouteCell ()

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *descriptionImageView;
@property (weak, nonatomic) IBOutlet UIButton *foldButton;

@property (weak, nonatomic) SGRouteUIInfo *data;
@end

@implementation SGRouteCell
{
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
   self.titleLabel.userInteractionEnabled = YES;
    self.descriptionLabel.userInteractionEnabled = YES;
    [self.titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldAction:)]];
    [self.descriptionLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldAction:)]];
}

- (IBAction)foldAction:(id)sender {
    [SGRouteCell calcRouteCelHeight:self.data fold:!self.data.fold];
    [self updateUI];
    
    [self.delegate cellHeightChanged:self];
}

- (void)updateUI
{
    CGRect frame = self.titleLabel.frame;
    frame.size.height = self.data.titleHeight;
    self.titleLabel.frame = frame;
    
    frame = self.descriptionLabel.frame;
    frame.origin.y = CGRectGetMaxY(self.titleLabel.frame) + 3;
    frame.size.height = self.data.descriptionHeight;
    self.descriptionLabel.frame = frame;
    
    frame = self.descriptionImageView.frame;
    frame.origin.y = CGRectGetMaxY(self.descriptionLabel.frame) + 10;
    self.descriptionImageView.frame = frame;
    
    self.foldButton.hidden = !self.data.showFoldButton;
    if (!self.foldButton.hidden) {
        frame = self.foldButton.frame;
        frame.origin.y = CGRectGetMaxY(self.descriptionLabel.frame) - CGRectGetHeight(frame) + 8;
        self.foldButton.frame = frame;
        
        if (!self.data.fold) {
            self.foldButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                                M_PI);
        } else {
            self.foldButton.transform = CGAffineTransformIdentity;
        }        
    }
}

- (void)showData:(SGRouteUIInfo *)data
{
    self.data = data;
    if (data.header) {
        CGRect frame = self.markImageView.frame;
        frame.origin.y = -8;
        self.markImageView.frame = frame;
        self.markImageView.image = [UIImage imageNamed:@"bg_dian"];
    } else {
        CGRect frame = self.markImageView.frame;
        frame.origin.y = 0;
        self.markImageView.frame = frame;
        UIImage *backgroundImage = [UIImage imageNamed:@"bg_number"];
        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, NO, [UIScreen mainScreen].scale);
        CGContextRef cgContextRef = UIGraphicsGetCurrentContext();
        [backgroundImage drawAtPoint:CGPointMake(0, 0)];
        CGContextSetRGBFillColor(cgContextRef, 1.0, 1.0, 1.0, 1.0);
        NSString *pinNumber = [NSString stringWithFormat:@"%d", data.index  + 1];
        CGSize size = [pinNumber sizeWithFont:[UIFont systemFontOfSize:11]];
        [pinNumber drawAtPoint:CGPointMake((int)((backgroundImage.size.width - size.width)/2), 6) withFont:[UIFont systemFontOfSize:11]];
        self.markImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    self.titleLabel.text = data.title;
    self.descriptionLabel.text = data.intro;
    if (data.imageUrl.length > 0) {
        self.descriptionImageView.hidden = NO;
        self.descriptionImageView.image = [UIImage imageNamed:data.imageUrl];
    } else {
        self.descriptionImageView.hidden = YES;
    }
    [self updateUI];
}

+ (void)calcRouteCelHeight:(SGRouteUIInfo *)data fold:(BOOL)fold
{
    static SGRouteCell *cell = nil;
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SGRouteCell" owner:nil options:nil];
        cell = [views objectAtIndex:0];
    }
    CGFloat offsetTitle = 0;
    CGFloat offsetDetail = 0;
    
    CGSize size = [data.title sizeWithFont:cell.titleLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(cell.titleLabel.frame), INT_MAX)];
    
    if (size.height > CGRectGetHeight(cell.titleLabel.frame)) {
        data.titleHeight = size.height;
        offsetTitle = (data.titleHeight - CGRectGetHeight(cell.titleLabel.frame));
    } else {
        data.titleHeight = CGRectGetHeight(cell.titleLabel.frame);
    }

    size = [data.intro sizeWithFont:cell.descriptionLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(cell.descriptionLabel.frame), INT_MAX)];
    if (size.height > CGRectGetHeight(cell.descriptionLabel.frame)) {
        data.showFoldButton = YES;
        if (!fold) {
            offsetDetail += (size.height - CGRectGetHeight(cell.descriptionLabel.frame));
        }
    } else {
        data.showFoldButton = NO;
    }
    if (data.intro.length == 0) {
        data.descriptionHeight = 0;
        offsetDetail = -CGRectGetHeight(cell.descriptionLabel.frame);
    } else {
        data.descriptionHeight = CGRectGetHeight(cell.descriptionLabel.frame) + offsetDetail;
    }
    
    if (data.imageUrl.length == 0) {
        offsetDetail -= (CGRectGetHeight(cell.descriptionImageView.frame) + 20);
    }
    data.fold = fold;
    data.height = CGRectGetHeight(cell.frame) + offsetTitle + offsetDetail;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
