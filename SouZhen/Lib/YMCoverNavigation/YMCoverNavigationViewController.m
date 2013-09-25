//
//  YMNavigationViewController.m
//  SouZhen
//
//  Created by chenwang on 13-8-17.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "YMCoverNavigationViewController.h"
#import "YMCoverViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface YMCoverNavigationViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) CGRect startingPanRect;

@end

@implementation YMCoverNavigationViewController
{
    UIPanGestureRecognizer * _panGestureRecognizer;
    BOOL _isPushFinished;
    BOOL _isPopFinished;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self =[super init]) {
        [self addChildViewController:rootViewController];
        _isPushFinished = YES;
        _isPopFinished = YES;
    }
    return self;
}

- (UINavigationBar *)navigationBar
{
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.childViewControllers.count > 0) {
        UIViewController *rootViewControlller = [self.childViewControllers objectAtIndex:0];
        [self pushViewController:rootViewControlller animated:NO];
    }
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [_panGestureRecognizer setDelegate:self];
    
    if(IPHONE_OS_7()) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (UIViewController *)topViewController
{
    return [self.childViewControllers lastObject];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!_isPushFinished) {
        return;
    }
    _isPushFinished = NO;
    
    [self.topViewController viewWillDisappear:NO];
    [self.topViewController viewDidDisappear:NO];
   
    ((YMCoverViewController *)viewController).navigationController = self;
    [self addChildViewController:viewController];
    
    
    if ([self.childViewControllers count] > 1) {
        
        UIImage *backImage = [UIImage imageNamed:@"icon_back"];
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
        customView.backgroundColor = [UIColor clearColor];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 7, 50, 30);
        [backButton setImage:backImage forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backToPreviousController) forControlEvents:UIControlEventTouchUpInside];
        
        [customView addSubview:backButton];
        [((YMCoverViewController *)viewController).navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:customView]];
    }
    
    
    viewController.view.layer.masksToBounds = NO;
    viewController.view.layer.shadowRadius = 10.f;
    viewController.view.layer.shadowOpacity = 0.8f;
    viewController.view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:viewController.view.bounds] CGPath];

    
    CGRect newFrame = self.view.bounds;
    newFrame.origin.x = CGRectGetMaxX(newFrame);
    viewController.view.frame = newFrame;
    
    [self.view addSubview:viewController.view];
    [viewController viewWillAppear:NO];
    [viewController viewDidAppear:NO];
    
    newFrame.origin.x = 0;
    
    [UIView
     animateWithDuration:animated?0.3f:0
     delay:0.0
     options:UIViewAnimationOptionTransitionNone
     animations:^{
         viewController.view.frame = newFrame;
     }
     completion:^(BOOL finished) {
         if ([self.childViewControllers count] > 1) {
             [self.view addGestureRecognizer:_panGestureRecognizer];
         }
         _isPushFinished = YES;
     }];
}

- (void)backToPreviousController
{
    [[self topViewController].navigationController popViewControllerAnimated:YES];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    int count = [self.childViewControllers count] - 1;
    for (int i=0; i<count; i++) {
        [self popViewControllerAnimated:NO];
    }
    return nil;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.childViewControllers.count == 1 || !_isPopFinished) {
        return nil;
    }
    _isPopFinished = NO;
    UIViewController *popViewController = [self.childViewControllers lastObject];
    CGRect newFrame = self.view.bounds;
    newFrame.origin.x = CGRectGetMaxX(newFrame);
    
    if (!animated) {
        popViewController.view.frame = newFrame;
        [popViewController.view removeFromSuperview];
        [popViewController removeFromParentViewController];
        [popViewController  viewWillDisappear:NO];
        [popViewController  viewDidDisappear:NO];
        if ([self.childViewControllers count] == 1) {
            [self.view removeGestureRecognizer:_panGestureRecognizer];
        }
        [self.topViewController viewWillAppear:NO];
        [self.topViewController viewDidAppear:NO];
        _isPopFinished = YES;
    } else {
        [UIView
         animateWithDuration:animated?0.3f:0
         delay:0.0
         options:UIViewAnimationOptionCurveEaseOut
         animations:^{
             popViewController.view.frame = newFrame;
         }
         completion:^(BOOL finished) {
             [popViewController.view removeFromSuperview];
             [popViewController removeFromParentViewController];
             [popViewController  viewWillDisappear:NO];
             [popViewController  viewDidDisappear:NO];
             if ([self.childViewControllers count] == 1) {
                 [self.view removeGestureRecognizer:_panGestureRecognizer];
             }
             [self.topViewController viewWillAppear:NO];
             [self.topViewController viewDidAppear:NO];
             
             _isPopFinished = YES;
         }];
    }


    return popViewController;
}


-(void)panGesture:(UIPanGestureRecognizer *)panGesture {
    if ([self topViewController].navigationItem.leftBarButtonItem == nil) {
        return;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.startingPanRect = [self topViewController].view.frame;
        case UIGestureRecognizerStateChanged:{
            CGRect newFrame = self.startingPanRect;
            CGPoint translatedPoint = [panGesture translationInView:self.view];
            newFrame.origin.x = CGRectGetMinX(self.startingPanRect)+translatedPoint.x;
            newFrame = CGRectIntegral(newFrame);
            CGFloat xOffset = newFrame.origin.x;
            if (xOffset > 0) {
                [[self topViewController].view setCenter:CGPointMake(CGRectGetMidX(newFrame), CGRectGetMidY(newFrame))];
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            self.startingPanRect = CGRectNull;
            CGPoint velocity = [panGesture velocityInView:[self topViewController].view];
            [self finishAnimationForPanGestureWithXVelocity:velocity.x completion:^(BOOL finished) {
                
            }];
            break;
        }
        default:
            break;
    }
}

-(void)finishAnimationForPanGestureWithXVelocity:(CGFloat)xVelocity completion:(void(^)(BOOL finished))completion{
    CGFloat animationVelocity = MAX(ABS(xVelocity), 200*2);
    if(xVelocity < 200){
        
    }
    else {
        
    }
    
    CGFloat currentOriginX = CGRectGetMinX([self topViewController].view.frame);
    CGFloat midPoint = 320 / 4.0;
    if(currentOriginX < midPoint) {
        [self closeDrawerAnimated:YES velocity:animationVelocity animationOptions:UIViewAnimationOptionCurveEaseOut completion:completion];
    } else {
        [[self topViewController].navigationController popViewControllerAnimated:YES];
//        [self backToPreviousController];
    }
    
}

-(void)closeDrawerAnimated:(BOOL)animated velocity:(CGFloat)velocity animationOptions:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion{
    CGRect newFrame = [self topViewController].view.bounds;
    
    CGFloat distance = ABS(CGRectGetMinX([self topViewController].view.frame));
    NSTimeInterval duration = MIN(distance/ABS(velocity), 0.15f);
    
    BOOL leftDrawerVisible = CGRectGetMinX([self topViewController].view.frame) > 0;
    
    CGFloat percentVisible = 0.0;
    
    if(leftDrawerVisible){
        CGFloat visibleDrawerPoints = CGRectGetMinX(self.view.frame);
        percentVisible = MAX(0.0,visibleDrawerPoints/320);
    }
    
    if (percentVisible >= 1.f) {
        CATransform3D transform;
        transform = CATransform3DMakeScale(percentVisible, 1.f, 1.f);
        transform = CATransform3DTranslate(transform, 320*(percentVisible-1.f)/2, 0.f, 0.f);
        [self topViewController].view.layer.transform = transform;
    }
    
    
    [UIView
     animateWithDuration:(animated?duration:0.0)
     delay:0.0
     options:options
     animations:^{
         [[self topViewController].view setFrame:newFrame];
     }
     completion:^(BOOL finished) {
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
