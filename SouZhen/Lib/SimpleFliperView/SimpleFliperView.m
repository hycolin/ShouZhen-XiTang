//
//  SimpleFliperView.m
//  Nova
//
//  Created by chenwang on 12-12-10.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import "SimpleFliperView.h"
#import "YMPageControl.h"
#import "SimpleFliperViewCell.h"

@interface SimpleFliperViewCell ()
- (void)setSelectedTarget:(id)target selector:(SEL)selector;
@end

@interface SimpleFliperView () <UIScrollViewDelegate>

@end

@implementation SimpleFliperView
{
    NSArray *list;
    
    UIButton *closeBtn;
    UIButton *selectedBtn;
    UIScrollView *scrollView;
    YMPageControl *pageCtrl;
    
    UIImageView *backgroundImageView;
    UIImageView *shadowImageView;
    
    NSInteger currentIndex;
    
    NSInteger contentCount;
    
    __unsafe_unretained id selTarget;
	SEL selSelector;
    
    __unsafe_unretained id cloTarget;
	SEL cloSelector;
    
    NSTimer *rTimer;
}

@synthesize dataArray = list;
@synthesize cellClass = _cellClass;
@synthesize backgroundImage;
@synthesize shadowImage;
@synthesize closeButtonImage;
@synthesize closeButtonHighlightImage;
@synthesize autoFliper;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self creatView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self creatView];
}

- (void)setCellClass:(Class)cellClass
{
    if (![cellClass isSubclassOfClass:[SimpleFliperViewCell class]]) {
        dlog(@"cellClass 必须为SimpleFliperViewCell的子类");
        return;
    }
    _cellClass = cellClass;
}

- (void)creatView {
    if (backgroundImage) {
        backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [backgroundImageView setImage:backgroundImage];
        [self addSubview:backgroundImageView];
    }
    
    if (shadowImage) {
        CGSize size = shadowImage.size;
        shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-size.width)/2, self.bounds.size.height - size.height, size.width, size.height)];
        [shadowImageView setImage:shadowImage];
        [self addSubview:shadowImageView];
    }
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];

    
    pageCtrl = [[YMPageControl alloc] init];
    pageCtrl.imageNormal = [UIImage imageNamed:@"pageCtrlGrey.png"];
    pageCtrl.imageCurrent = [UIImage imageNamed:@"pageCtrlOrg.png"];
    pageCtrl.hidesForSinglePage = YES;
    [self addSubview:pageCtrl];
    CGRect frame = pageCtrl.frame;
    frame.origin.x = self.frame.size.width - 50;
    frame.origin.y = self.frame.size.height - 15;
    pageCtrl.frame = frame;
    


    if (cloTarget) {
        closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:self.closeButtonImage forState:UIControlStateNormal];
        [closeBtn setImage:self.closeButtonHighlightImage forState:UIControlStateHighlighted];
        closeBtn.frame = CGRectMake(self.frame.size.width-50, 0, 50, 50);
        
        [self addSubview:closeBtn];
    }
}

- (void)cleanView {
    [backgroundImageView removeFromSuperview];
    backgroundImageView = nil;

    [shadowImageView removeFromSuperview];
    shadowImageView = nil;
    
    [scrollView removeFromSuperview];
    scrollView = nil;
    
    [closeBtn removeFromSuperview];
    closeBtn = nil;
    
    [pageCtrl removeFromSuperview];
    pageCtrl = nil;
}

- (void)reloadData {
    
    for (id view in [scrollView subviews]) {
        [((UIView*)view) removeFromSuperview];
    }
    
    if ([list count] < 2) {
        [scrollView setContentSize:self.frame.size];
        [scrollView setContentOffset:CGPointMake(0, 0)];
        scrollView.scrollEnabled = NO;
        SimpleFliperViewCell *view = [[self.cellClass alloc] initWithFrame:self.bounds];
        [view setSelectedTarget:self selector:@selector(cellClicked:)];
        view.data = [list objectAtIndex:0];
        [scrollView addSubview:view];
        return;
    }
    
    scrollView.scrollEnabled = YES;
    
    float cellWidth = self.frame.size.width;
    float cellHeight = self.frame.size.height;
    
    SimpleFliperViewCell *view = [[self.cellClass alloc] initWithFrame:self.bounds];
    
    [view setSelectedTarget:self selector:@selector(cellClicked:)];
    view.data = [list objectAtIndex:[list count] - 2];
    [scrollView addSubview:view];
    
    view = [[self.cellClass alloc] initWithFrame:CGRectMake(cellWidth, 0, cellWidth, cellHeight)];
    [view setSelectedTarget:self selector:@selector(cellClicked:)];
    view.data = [list objectAtIndex:[list count] - 1];
    [scrollView addSubview:view];
    
    for (int i = 0;i<[list count];i++) {
        SimpleFliperViewCell *subView = [[self.cellClass alloc] initWithFrame:CGRectMake((cellWidth * i) + cellWidth*2, 0, cellWidth, cellHeight)];
        [subView setSelectedTarget:self selector:@selector(cellClicked:)];
        subView.data = [list objectAtIndex:i];
        [scrollView addSubview:subView];
    }
    
    //add the first image at the end
    view = [[self.cellClass alloc] initWithFrame:CGRectMake((cellWidth * ([list count] + 2)), 0, cellWidth, cellHeight)];
    [view setSelectedTarget:self selector:@selector(cellClicked:)];
    view.data = [list objectAtIndex:0];
    [scrollView addSubview:view];
    
    view = [[self.cellClass alloc] initWithFrame:CGRectMake((cellWidth * ([list count] + 3)), 0, cellWidth, cellHeight)];
    [view setSelectedTarget:self selector:@selector(cellClicked:)];
    view.data = [list objectAtIndex:1];
    [scrollView addSubview:view];
    
    [scrollView setContentSize:CGSizeMake(cellWidth * ([list count] + 4), cellHeight)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(cellWidth*2, 0, cellWidth, cellHeight) animated:NO];
    
    pageCtrl.currentPage = 0;
    
    if (self.autoFliper) {
        [self startTimer];
    }
}

- (void)setDataArray:(NSArray*)array {
    
    if (!array || [array count] == 0) {
        return;
    }
    
    if (list != array) {
        list = array;
        
        [self cleanView];
        [self creatView];
        
        pageCtrl.numberOfPages = [list count];
        
        [self closeTimer];
        
        [self reloadData];
    }
}

#pragma scrollview delegate
- (void)updateScrollView:(CGPoint)contentOffset {
    int currentPage = floor((contentOffset.x - scrollView.frame.size.width
                             / ([list count]+4)) / scrollView.frame.size.width) + 1;
    
    float cellWidth = self.frame.size.width;
    float cellHeight = self.frame.size.height;
    if (currentPage == 0) {
        //go last but 1 page
        [scrollView scrollRectToVisible:CGRectMake(cellWidth * 2 + ([list count]-2)*cellWidth, 0, cellWidth, cellHeight) animated:NO];
    } else  {
        if (currentPage == ([list count]+2)) {
            //如果是最后+1,也就是要开始循环的第一个
            [scrollView scrollRectToVisible:CGRectMake(cellWidth * 2, 0, cellWidth, cellHeight) animated:NO];
        }
        
        if (currentPage == ([list count]+3)) {
            //如果是最后+2,也就是要开始循环的第2个
            [scrollView scrollRectToVisible:CGRectMake(cellWidth * 3, 0, cellWidth, cellHeight) animated:NO];
        }
    }
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    [self closeTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)sView {
    [self updateScrollView:sView.contentOffset];
    
    currentIndex = ceil((sView.contentOffset.x-self.frame.size.width*2)/self.frame.size.width);
    NSInteger index = (currentIndex + [list count])%[list count];
    pageCtrl.currentPage = index;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    
    [self updateScrollView:sView.contentOffset];
    
    currentIndex = ceil((scrollView.contentOffset.x-self.frame.size.width*2)/self.frame.size.width);
    NSInteger index = (currentIndex + [list count])%[list count];
    pageCtrl.currentPage = index;
    
    if (self.autoFliper) {
        [self startTimer];
    }
}

- (void)setSelectedTarget:(id)target selector:(SEL)selector {
    selTarget = target;
	selSelector = selector;
}

- (void)setCloseTarget:(id)target selector:(SEL)selector {
    cloTarget = target;
    cloSelector = selector;
}

- (void)cellClicked:(id)sender {
    [selTarget performSelector:selSelector withObject:[list objectAtIndex:pageCtrl.currentPage]];
}

- (void)closeBtnClicked:(id)sender {
    [cloTarget performSelector:cloSelector withObject:nil];
}


- (void)handleTimer:(id)sender {
    
    if (!list || [list count] < 2)
    {
        return;
    }
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.x += self.frame.size.width;
    [scrollView setContentOffset:contentOffset animated:YES];
    
    [self updateScrollView:scrollView.contentOffset];
    
    currentIndex = ceil((contentOffset.x-self.frame.size.width*2)/self.frame.size.width);
    NSInteger index = (currentIndex+[list count])%[list count];
    pageCtrl.currentPage = index;
    
}

- (void)closeTimer {
    if (rTimer) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(handleTimer:) object:rTimer];
        [rTimer invalidate];
        rTimer = nil;
    }
}

- (void)startTimer {
    if (rTimer == nil) {
        //时间间隔
        NSTimeInterval timeInterval = 4.0 ;
        //定时器
        rTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self
                                                selector:@selector(handleTimer:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (NSInteger)fliperIndex
{
    return pageCtrl.currentPage;
}

- (void)dealloc {
    [rTimer invalidate];
}

@end



