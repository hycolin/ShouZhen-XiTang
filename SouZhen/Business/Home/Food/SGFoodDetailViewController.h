//
//  SGFoodDetailViewController.h
//  SouZhen
//
//  Created by chenwang on 13-9-1.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGViewController.h"

@interface SGFoodDetailViewController : SGViewController

@property (nonatomic, strong) SGFoodData *food;

@end


@interface SGFoodPhotoCell : UITableViewCell

@property (nonatomic, weak) SGFoodDetailViewController *foodDetailViewController;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;


- (void)showPhoto:(NSString *)photoName;


@end

@interface SGFoodInfoCell : UITableViewCell

@property (nonatomic, weak) SGFoodDetailViewController *foodDetailViewController;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *foldButton;


- (void)showInfo:(NSString *)info mark:(NSString *)mark;

@end