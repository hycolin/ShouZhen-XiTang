//
//  SGHouseCell.m
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHouseCell.h"

@interface SGHouseCell ()


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *houseImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@end

@implementation SGHouseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    self.houseImageView.layer.masksToBounds = YES;
    self.houseImageView.layer.cornerRadius = 5;
}

- (void)showData:(SGHouseTypeData *)data
{
    self.nameLabel.text = data.name;
    self.houseImageView.image = [UIImage imageNamed:data.imageUrl];
    self.priceLabel.text = [NSString stringWithFormat:@"%g", data.price];
}

@end
