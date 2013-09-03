//
//  SimpleFliperViewCell.m
//  Nova
//
//  Created by chenwang on 12-12-10.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import "SimpleFliperViewCell.h"

@interface SimpleFliperViewCell ()
@property (nonatomic, unsafe_unretained, readonly) id selectedTarget;
@property (nonatomic, assign, readonly) SEL selectedAction;
@end

@implementation SimpleFliperViewCell
{
    __unsafe_unretained id _target;
    SEL _selector;
    UIButton *_button;
}
@synthesize data;
@synthesize selectedTarget = _target;
@synthesize selectedAction = _selector;
@synthesize selectedButton = _button;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UIButton alloc] initWithFrame:self.bounds];
        [_button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

- (void)btnClicked:(id)sender {
    [self.selectedTarget performSelector:self.selectedAction withObject:self.data];
}

- (void)setSelectedTarget:(id)target selector:(SEL)selector
{
    _target = target;
    _selector = selector;
}
@end