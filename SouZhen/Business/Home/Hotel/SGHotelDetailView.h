//
//  SGHotelDetailView.h
//  SouZhen
//
//  Created by chenwang on 13-8-31.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGHotelDetailViewController;

@interface SGHotelDetailView : UIView

@property (weak, nonatomic) SGHotelDetailViewController *hotelDetailController;
- (void)showData:(SGHotelData *)data;

- (void)updateUI;
- (void)openAddress;

@end

//客栈图片
@interface SGHotelPhotoCell : UITableViewCell
@property (nonatomic, strong) SGHotelData *hotelData;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


@property (nonatomic, weak) SGHotelDetailView *parentView;
@end

//客栈详情
@interface SGHotelDetailCell : UITableViewCell

@property (nonatomic, weak) SGHotelDetailView *parentView;

@property (weak, nonatomic) IBOutlet UILabel *labelMark;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIButton *foldButton;
@property (nonatomic, strong) SGHotelData *hotelData;

@end

//地址
@interface SGHotelAddressCell : UITableViewCell

@property (nonatomic, weak) SGHotelDetailView *parentView;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) SGHotelData *hotelData;

@end

// 特色服务
@interface SGHotelServiceCell : UITableViewCell
@property (nonatomic, weak) SGHotelDetailView *parentView;
@property (weak, nonatomic) IBOutlet UIButton *serviceButton;
@property (weak, nonatomic) IBOutlet UIButton *foldButton;
@property (nonatomic, strong) SGHotelData *hotelData;
@end

//到店方式
@interface SGHotelWayCell : UITableViewCell

@property (nonatomic, weak) SGHotelDetailView *parentView;
@property (weak, nonatomic) IBOutlet UIButton *wayButton;
@property (weak, nonatomic) IBOutlet UIButton *foldButton;
@property (nonatomic, strong) SGHotelData *hotelData;

@end