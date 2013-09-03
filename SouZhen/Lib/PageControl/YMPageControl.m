//
//  NVPageControl.m
//  NVScope
//
//  Created by zhou cindy on 10-12-13.
//  Copyright 2010 dianping.com. All rights reserved.
//

#import "YMPageControl.h"


@interface YMPageControl ()
- (void)updateDots;
@end


@implementation YMPageControl

@synthesize imageNormal = mImageNormal;
@synthesize imageCurrent = mImageCurrent;

- (void)dealloc
{
}


/** override to update dots */
- (void) setCurrentPage:(NSInteger)currentPage
{
	[super setCurrentPage:currentPage];
	
	// update dot views
	[self updateDots];
}

/** override to update dots */
- (void) updateCurrentPageDisplay
{
	[super updateCurrentPageDisplay];
	
	// update dot views
	[self updateDots];
}

/** Override setImageNormal */
- (void) setImageNormal:(UIImage*)image
{
	mImageNormal = image;
	
	// update dot views
	[self updateDots];
}

/** Override setImageCurrent */
- (void) setImageCurrent:(UIImage*)image
{
	mImageCurrent = image;
	
	// update dot views
	[self updateDots];
}

/** Override to fix when dots are directly clicked */
- (void) endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event 
{
	[super endTrackingWithTouch:touch withEvent:event];
	
	[self updateDots];
}

#pragma mark - (Private)

- (void) updateDots
{
	if(mImageCurrent || mImageNormal)
	{
		// Get subviews
		NSArray* dotViews = self.subviews;
		for(int i = 0; i < dotViews.count; ++i)
		{
			UIImageView* dot = [dotViews objectAtIndex:i];
            if ([dot isKindOfClass:[UIImageView class]]) {
                // Set image
                dot.image = (i == self.currentPage) ? mImageCurrent : mImageNormal;
            }
		}
	}
}

@end
