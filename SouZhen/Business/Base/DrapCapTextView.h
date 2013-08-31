//
//  CustomTextView.h
//  CustomText
//
//  Created by chen yuan on 7/3/13.
//  Copyright (c) 2013 chen yuan. All rights reserved.
//

//目前仅支持左上角特殊处理显示
#import <UIKit/UIKit.h>

@interface DrapCapTextView : UIView
{
    NSString * drapCapText;
    NSString * text;
    UIColor * textColor;
    NSString * fontName;
    float dropCapFontSize;
    float textFontSize;
    float lineSpace;
    NSTextAlignment textAlignment;
}

@property (strong, nonatomic) NSString * drapCapText;       //头部放大文字
@property (strong, nonatomic) NSString * text;              //内容文字
@property (strong, nonatomic) UIColor * textColor;          //字体颜色
@property (strong, nonatomic) NSString * fontName;          //字体familyName
@property (assign, nonatomic) float dropCapFontSize;        //头部文字大小
@property (assign, nonatomic) float textFontSize;           //内容文字大小
@property (assign, nonatomic) float lineSpace;              //行间距
@property (assign, nonatomic) NSTextAlignment textAlignment;//对齐方式
@end
