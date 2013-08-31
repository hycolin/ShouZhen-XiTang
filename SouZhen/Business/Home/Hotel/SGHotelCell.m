//
//  SGHotelCell.m
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHotelCell.h"
#import <QuartzCore/QuartzCore.h>

@interface SGHotelCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end

@implementation SGHotelCell

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
    self.hotelImageView.layer.masksToBounds = YES;
    self.hotelImageView.layer.cornerRadius = 5;
}

- (void)showData:(SGHotelData *)data
{
    self.nameLabel.text = data.name;
    self.hotelImageView.image = [UIImage imageNamed:data.imageUrl];
    self.addressLabel.text = data.address;
    self.phoneLabel.text = data.phone;
}

@end
