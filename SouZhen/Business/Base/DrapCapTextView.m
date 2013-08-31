//
//  CustomTextView.m
//  CustomText
//
//  Created by chen yuan on 7/3/13.
//  Copyright (c) 2013 chen yuan. All rights reserved.

#import "DrapCapTextView.h"
#import <CoreText/CoreText.h>

@implementation DrapCapTextView
{
    int dropCapKernValue;
}
@synthesize drapCapText, text, textColor, fontName, dropCapFontSize, textFontSize, lineSpace, textAlignment;

+ (CTTextAlignment)nstextAlignment2cttextAlignment:(NSTextAlignment)alignment
{
    if (!IPHONE_OS_6()) {
        CTTextAlignment cttextAlignment;
        switch (alignment) {
            case NSTextAlignmentLeft:
                cttextAlignment = kCTLeftTextAlignment;
                break;
            case NSTextAlignmentCenter:
                cttextAlignment = kCTCenterTextAlignment;
                break;
            case NSTextAlignmentRight:
                cttextAlignment = kCTRightTextAlignment;
                break;
            case NSTextAlignmentJustified:
                cttextAlignment = kCTJustifiedTextAlignment;
                break;
            case NSTextAlignmentNatural:
                cttextAlignment = kCTNaturalTextAlignment;
                break;
            default:
                cttextAlignment = kCTLeftTextAlignment;
                break;
        }
        return cttextAlignment;
    }
    else
    {
        return NSTextAlignmentToCTTextAlignment(alignment);
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    textColor = [UIColor darkGrayColor];
    fontName = @"Helvetica";
    dropCapFontSize = 20.0f;
    textFontSize = 8.0f;
    textAlignment = NSTextAlignmentLeft;
    dropCapKernValue = 1;
    lineSpace = 5.0f;
}

- (void)drawRect:(CGRect)rect {
    
#ifdef _DEBUG
    NSAssert(text != nil, @"text is nil");
    NSAssert(textColor != nil, @"textColor is nil");
    NSAssert(fontName != nil, @"fontName is nil");
    NSAssert(dropCapFontSize > 0, @"dropCapFontSize is <= 0");
    NSAssert(textFontSize > 0, @"textFontSize is <=0");
#endif
    
    CTTextAlignment ctTextAlignment = [DrapCapTextView nstextAlignment2cttextAlignment:textAlignment];
    CTLineBreakMode ctLineBreakMode = kCTLineBreakByCharWrapping;
    CTParagraphStyleSetting paragraphStyleSettings[] = { {
        .spec = kCTParagraphStyleSpecifierAlignment,
        .valueSize = sizeof ctTextAlignment,
        .value = &ctTextAlignment
    }, {
        .spec = kCTParagraphStyleSpecifierLineSpacingAdjustment,
        .valueSize = sizeof(lineSpace),
        .value = &lineSpace
    }, {
        .spec = kCTParagraphStyleSpecifierLineBreakMode,
        .valueSize = sizeof ctLineBreakMode,
        .value = &ctLineBreakMode
    }
    };
    
    CFIndex settingCount = sizeof paragraphStyleSettings / sizeof *paragraphStyleSettings;
    CTParagraphStyleRef style = CTParagraphStyleCreate(paragraphStyleSettings, settingCount);
    
    CTFontRef dropCapFontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, dropCapFontSize, NULL);
    CTFontRef textFontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, textFontSize, NULL);
    
    NSDictionary *dropCapDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 (__bridge id)dropCapFontRef, kCTFontAttributeName,
                                 textColor.CGColor, kCTForegroundColorAttributeName,
                                 style, kCTParagraphStyleAttributeName,
                                 @(dropCapKernValue) , kCTKernAttributeName,
                                 nil];
    CFDictionaryRef dropCapAttributes = (__bridge CFDictionaryRef)dropCapDict;
    
    NSDictionary *textDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              (__bridge id)textFontRef, kCTFontAttributeName,
                              textColor.CGColor, kCTForegroundColorAttributeName,
                              style, kCTParagraphStyleAttributeName,
                              nil];
    CFDictionaryRef textAttributes = (__bridge CFDictionaryRef)textDict;
    
    CFRelease(dropCapFontRef);
    CFRelease(textFontRef);
    CFRelease(style);
    
    CFAttributedStringRef dropCapString = CFAttributedStringCreate(kCFAllocatorDefault,
                                                                   (__bridge CFStringRef)drapCapText,
                                                                   dropCapAttributes);
    
    CFAttributedStringRef textString = CFAttributedStringCreate(kCFAllocatorDefault,
                                                                (__bridge CFStringRef)text,
                                                                textAttributes);
    
    CTFramesetterRef dropCapSetter = CTFramesetterCreateWithAttributedString(dropCapString);
    
    CTFramesetterRef textSetter = CTFramesetterCreateWithAttributedString(textString);
    
    CFRelease(dropCapString);
    CFRelease(textString);
    
    //计算头部文字大小
    CFRange range;
    CGSize maxSizeConstraint = self.frame.size;
    CGSize dropCapSize = CTFramesetterSuggestFrameSizeWithConstraints(dropCapSetter,
                                                                      CFRangeMake(0, [drapCapText length]),
                                                                      dropCapAttributes,
                                                                      maxSizeConstraint,
                                                                      &range);
    
    //设定textFrame的渲染区域，此处用Path描述
    int pad = 3;
    CGMutablePathRef textBox = CGPathCreateMutable();
    CGPathMoveToPoint(textBox, nil, dropCapSize.width + pad, 0);
    CGPathAddLineToPoint(textBox, nil, dropCapSize.width + pad, dropCapSize.height * 0.8);
    CGPathAddLineToPoint(textBox, nil, 0, dropCapSize.height * 0.8);
    CGPathAddLineToPoint(textBox, nil, 0, self.frame.size.height);
    CGPathAddLineToPoint(textBox, nil, self.frame.size.width, self.frame.size.height);
    CGPathAddLineToPoint(textBox, nil, self.frame.size.width, 0);
    CGPathCloseSubpath(textBox);
    
    CGAffineTransform flipTransform = CGAffineTransformIdentity;
    flipTransform = CGAffineTransformTranslate(flipTransform,
                                               0,
                                               self.bounds.size.height);
    flipTransform = CGAffineTransformScale(flipTransform, 1, -1);
    
    CGPathRef invertedTextBox = CGPathCreateCopyByTransformingPath(textBox,
                                                                   &flipTransform);
    CFRelease(textBox);
    
    CTFrameRef textFrame = CTFramesetterCreateFrame(textSetter,
                                                    CFRangeMake(0, 0),
                                                    invertedTextBox,
                                                    NULL);
    CFRelease(invertedTextBox);
    CFRelease(textSetter);
    
    CGPathRef dropCapTextBox = CGPathCreateWithRect(CGRectMake(dropCapKernValue / 2.0f,
                                                               0,
                                                               dropCapSize.width,
                                                               dropCapSize.height),
                                                    &flipTransform);
    CTFrameRef dropCapFrame = CTFramesetterCreateFrame(dropCapSetter,
                                                       CFRangeMake(0, 0),
                                                       dropCapTextBox,
                                                       NULL);
    CFRelease(dropCapTextBox);
    CFRelease(dropCapSetter);
    
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGContextSaveGState(gc); {
        CGContextConcatCTM(gc, flipTransform);
        CTFrameDraw(dropCapFrame, gc);
        CTFrameDraw(textFrame, gc);
    } CGContextRestoreGState(gc);
    CFRelease(dropCapFrame);
    CFRelease(textFrame);
}

@end
