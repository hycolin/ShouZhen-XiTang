//
//  SGSceneryCell.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGEntertainmentCell.h"
#import "SGStarView.h"
#import <QuartzCore/QuartzCore.h>

@interface SGEntertainmentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation SGEntertainmentCell

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

- (void)showData:(SGEntertainmentData *)data
{
    self.sImageView.image = [UIImage imageNamed:data.imageUrl];
    self.nameLabel.text = data.name;
    self.categoryLabel.text = data.categoryName;
    self.addressLabel.text = data.address;
}

@end
