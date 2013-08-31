//
//  SGStarView.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGStarView.h"

@implementation SGStarView
{
    NSMutableArray *_starImageViews;
}

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
    self.backgroundColor = [UIColor clearColor];
    _starImageViews = [NSMutableArray arrayWithCapacity:5];
    float startX = 0;
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, 0, 12, 12)];
        [self addSubview:imageView];
        startX += 13;
        [_starImageViews addObject:imageView];
    }
}

- (void)setStar:(NSInteger)star
{
    for (int i=0; i<[_starImageViews count]; i++) {
        UIImageView *imageView = [_starImageViews objectAtIndex:i];
        if (i < star) {
            imageView.image = [UIImage imageNamed:@"icon_star_d"];
        } else {
            imageView.image = [UIImage imageNamed:@"icon_star_u"];
        }
    }
}

@end
