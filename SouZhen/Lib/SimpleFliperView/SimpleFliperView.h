//
//  SimpleFliperView.h
//  Nova
//
//  Created by chenwang on 12-12-10.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 支持多个视图切换的控件,每个视图只支持同一种类型，例如公告显示
*/
@interface SimpleFliperView : UIView
{
}
@property (nonatomic, retain) NSArray *dataArray; //数据集合
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) BOOL autoFliper; //是否需要自动滚动
@property (nonatomic, assign) NSInteger fliperIndex; //当前显示的视图索引

// 配置样式
@property (nonatomic, strong) UIImage *backgroundImage; //背景图片
@property (nonatomic, strong) UIImage *shadowImage; //阴影图片
@property (nonatomic, strong) UIImage *closeButtonImage; //关闭按钮的图片
@property (nonatomic, strong) UIImage *closeButtonHighlightImage; //关闭按钮的高亮图片

// 当用户选中某个cell时触发回调
- (void)setSelectedTarget:(id)target selector:(SEL)selector;

// 当设置closeTarget后，整个控件的右边会显示一个关闭按钮
- (void)setCloseTarget:(id)target selector:(SEL)selector;

@end
