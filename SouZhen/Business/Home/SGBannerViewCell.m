//
//  SGBannerViewCell.m
//  SouZhen
//
//  Created by chenwang on 13-9-3.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGBannerViewCell.h"

@interface SGBannerViewCell ()

@end

@implementation SGBannerViewCell

- (void)setData:(id)data
{
    NSString *imageName = [((NSDictionary *)data) objectForKey:@"image"];
    [self.selectedButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
