//
//  NVPageControl.h
//  NVScope
//
//  Created by zhou cindy on 10-12-13.
//  Copyright 2010 dianping.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YMPageControl : UIPageControl {

	UIImage* mImageNormal;
	UIImage* mImageCurrent;
}

@property (nonatomic, readwrite, retain) UIImage* imageNormal;
@property (nonatomic, readwrite, retain) UIImage* imageCurrent;

@end
