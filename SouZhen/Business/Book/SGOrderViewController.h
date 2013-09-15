//
//  SGOrderViewController.h
//  SouZhen
//
//  Created by chenwang on 13-9-5.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGViewController.h"

@interface SGOrderViewController : SGViewController

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic) double price;
@property (nonatomic) double discount;

@end
