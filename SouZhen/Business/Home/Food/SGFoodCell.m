//
//  SGFoodCell.m
//  SouZhen
//
//  Created by chenwang on 13-9-1.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGFoodCell.h"

@interface SGFoodCell ()

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;


@end

@implementation SGFoodCell

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
    self.foodImageView.layer.masksToBounds = YES;
    self.foodImageView.layer.cornerRadius = 5;
}

- (void)showFood:(SGFoodData *)food
{
    self.foodImageView.image = [UIImage imageNamed:food.imageUrl];
    self.nameLabel.text = food.name;
    self.categoryLabel.text = food.categoryName;
}

@end
