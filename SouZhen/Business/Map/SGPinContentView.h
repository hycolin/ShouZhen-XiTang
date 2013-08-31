//
//  SGPinContentView.h
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGAnnotation.h"

@class SGPinContentView;
@protocol SGPinContentViewDelegate <NSObject>

- (void)pinContentView:(SGPinContentView *)pinContentView didSelectAtAnnotation:(SGAnnotation *)annotation;

@end

@interface SGPinContentView : UIView

@property (weak, atomic) id<SGPinContentViewDelegate> delegate;
@property (nonatomic, weak) SGAnnotation *annotation;

- (void)showAnnotation:(SGAnnotation *)annotation;

@end
