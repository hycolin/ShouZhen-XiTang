//
//  SGNewsCell.m
//  SouZhen
//
//  Created by chenwang on 13-9-1.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGNewsCell.h"

@interface SGNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end


@implementation SGNewsCell

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
    self.sImageView.layer.masksToBounds = YES;
    self.sImageView.layer.cornerRadius = 5;
}

- (void)showData:(SGNewsData *)data
{
    self.sImageView.image = [UIImage imageNamed:data.thumbImageUrl];
    self.nameLabel.text = data.title;
    self.dateLabel.text = data.time;
}

@end
