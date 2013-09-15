//
//  SGTrafficHighwayView.m
//  SouZhen
//
//  Created by chenwang on 13-9-14.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGTrafficHighwayView.h"

@interface SGTrafficHighwayView ()

@property (nonatomic, weak) IBOutlet UIImageView *markImageView;
@end

@implementation SGTrafficHighwayView

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
    self.markImageView.image = [[UIImage imageNamed:@"bg_btl.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
