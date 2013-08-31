//
//  SGSceneryCell.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGSceneryCell.h"
#import "SGStarView.h"
#import <QuartzCore/QuartzCore.h>

@interface SGSceneryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet SGStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *priceMarkView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation SGSceneryCell

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
    self.sImageView.layer.masksToBounds = YES;
    self.sImageView.layer.cornerRadius = 5;
}

- (void)showSceneryData:(SGSceneryData *)data
{
    self.sImageView.image = [UIImage imageNamed:data.imageUrl];
    self.nameLabel.text = data.name;
    self.categoryLabel.text = data.categoryName;
    [self.starView setStar:data.star];
    
    if (data.price > 0) {
        self.priceMarkView.hidden = NO;
        self.priceLabel.text = [NSString stringWithFormat:@"%.0f", data.price];
    } else {
        self.priceMarkView.hidden = YES;
        self.priceLabel.text = @"免费";
    }
}

@end
