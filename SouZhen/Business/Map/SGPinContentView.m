//
//  SGPinContentView.m
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGPinContentView.h"

@interface SGPinContentView ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end

@implementation SGPinContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showAnnotation:(SGAnnotation *)annotation
{
    self.annotation = annotation;
    self.leftImageView.image =  [UIImage imageNamed:annotation.leftImage];
    self.titleLabel.text = annotation.title;
    self.subTitleLabel.text = annotation.subtitle;
}

- (IBAction)action:(id)sender {
    [self.delegate pinContentView:self didSelectAtAnnotation:self.annotation];
}


@end
