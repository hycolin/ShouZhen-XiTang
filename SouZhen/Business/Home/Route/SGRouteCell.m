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

- (IBAction)foldAction:(id)sender {
    [SGRouteCell calcRouteCelHeight:self.data fold:!self.data.fold];
    [self updateUI];
    
    [self.delegate cellHeightChanged:self];
}

- (void)updateUI
{
    CGRect frame = self.descriptionLabel.frame;
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
        CGSize size = [pinNumber sizeWithFont:[UIFont systemFontOfSize:13]];
        [pinNumber drawAtPoint:CGPointMake((int)((backgroundImage.size.width - size.width)/2)+1, 4) withFont:[UIFont systemFontOfSize:13]];
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
    CGFloat offset = 0;

    CGSize size = [data.intro sizeWithFont:cell.descriptionLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(cell.descriptionLabel.frame), INT_MAX)];
    if (size.height > CGRectGetHeight(cell.descriptionLabel.frame)) {
        data.showFoldButton = YES;
        if (!fold) {
            offset += (size.height - CGRectGetHeight(cell.descriptionLabel.frame));
        }
    } else {
        data.showFoldButton = NO;
    }
    data.descriptionHeight = CGRectGetHeight(cell.descriptionLabel.frame) + offset;
    
    if (data.imageUrl.length == 0) {
        offset -= (CGRectGetHeight(cell.descriptionImageView.frame) + 20);
    }
    data.fold = fold;
    data.height = CGRectGetHeight(cell.frame) + offset;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
