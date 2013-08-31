//
//  SGRouteCell.h
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGRouteUIInfo.h"

@class SGRouteCell;
@protocol SGRouteCellDelegate <NSObject>

- (void)cellHeightChanged:(SGRouteCell *)cell;

@end

@interface SGRouteCell : UITableViewCell

@property (nonatomic, weak) id<SGRouteCellDelegate> delegate;

+ (void)calcRouteCelHeight:(SGRouteUIInfo *)data fold:(BOOL)fold;

- (void)showData:(SGRouteUIInfo *)data;

@end
