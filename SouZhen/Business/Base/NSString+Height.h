//
//  NSString+height.h
//  Dianping
//
//  Created by zhou cindy on 12-4-13.
//  Copyright (c) 2012年 dianping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (height)

-(CGSize)sgSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;
-(CGSize)sgSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
-(CGSize)sgSizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
-(CGSize)sgSizeWithFont:(UIFont *)font;
@end
