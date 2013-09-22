//
//  SGHouseTypeDetailView.m
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGHouseTypeDetailView.h"

@interface SGHouseTypeDetailView ()

@property (weak, nonatomic) IBOutlet UIImageView *houseTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *beddingLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *facilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end


@implementation SGHouseTypeDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showData:(SGHouseTypeData *)data
{
    self.houseTypeImageView.image = [UIImage imageNamed:data.imageUrl];
    self.nameLabel.text = data.name;
    self.beddingLabel.text = data.bedding;
    self.sizeLabel.text = data.size;
    self.facilityLabel.text = data.facility;
    self.descriptionLabel.text = data.intro;
    
    CGRect frame = self.descriptionLabel.frame;
    frame.size.height = ceilf([data.intro sgSizeWithFont:self.descriptionLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.descriptionLabel.frame), 9999)].height);
    self.descriptionLabel.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(320, self.descriptionLabel.frame.origin.y + CGRectGetHeight(self.descriptionLabel.frame) + 10);
}

@end
