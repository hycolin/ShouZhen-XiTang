#import "CalloutMapAnnotationView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#define CalloutMapAnnotationViewBottomShadowBufferSize 6.0f
#define CalloutMapAnnotationViewContentHeightBuffer 8.0f
#define CalloutMapAnnotationViewHeightAboveParent 2.0f

@interface CalloutMapAnnotationView()

@property (nonatomic, readonly) CGFloat yShadowOffset;
@property (nonatomic) BOOL animateOnNextDrawRect;
@property (nonatomic) CGRect endFrame;

- (void)prepareContentFrame;
- (void)prepareFrameSize;
- (CGFloat)relativeParentXPosition;
- (void)adjustMapRegionIfNeeded;

- (void)animateIn;
- (void)animateInStepTwo;
- (void)animateInStepThree;

@end


@implementation CalloutMapAnnotationView

@synthesize parentAnnotationView = _parentAnnotationView;
@synthesize mapView = _mapView;
@synthesize contentView = _contentView;
@synthesize animateOnNextDrawRect = _animateOnNextDrawRect;
@synthesize endFrame = _endFrame;
@synthesize yShadowOffset = _yShadowOffset;
@synthesize offsetFromParent = _offsetFromParent;
@synthesize contentHeight = _contentHeight;
@synthesize contentWidth = _contentWidth;

- (id) initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
		self.contentHeight = 80.0;
        self.contentWidth = 32.0;
		self.enabled = NO;
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)setAnnotation:(id <MKAnnotation>)annotation {
	[super setAnnotation:annotation];
	[self prepareFrameSize];
	[self prepareContentFrame];
	[self setNeedsDisplay];
}

- (void)prepareFrameSize {
	CGRect frame = self.frame;
	frame.size = CGSizeMake(self.contentWidth,
                            self.contentHeight);
	self.frame = frame;
}

- (void)prepareContentFrame {
	CGRect contentFrame = CGRectMake(0, 0,
                                     self.contentWidth,
									 self.contentHeight);

	self.contentView.frame = contentFrame;
}

//if the pin is too close to the edge of the map view we need to shift the map view so the callout will fit.
- (void)adjustMapRegionIfNeeded {
    CLLocationCoordinate2D coordinate = self.parentAnnotationView.annotation.coordinate;
    [self.mapView setCenterCoordinate:coordinate animated:YES];

    self.centerOffset = CGPointMake(0, - (self.parentAnnotationView.frame.size.height+15));
}

- (CGFloat)xTransformForScale:(CGFloat)scale {
	CGFloat xDistanceFromCenterToParent = self.endFrame.size.width / 2 - [self relativeParentXPosition];
	return (xDistanceFromCenterToParent * scale) - xDistanceFromCenterToParent;
}

- (CGFloat)yTransformForScale:(CGFloat)scale {
	CGFloat yDistanceFromCenterToParent = (((self.endFrame.size.height) / 2) + self.offsetFromParent.y + CalloutMapAnnotationViewBottomShadowBufferSize + CalloutMapAnnotationViewHeightAboveParent);
	return yDistanceFromCenterToParent - yDistanceFromCenterToParent * scale;
}

- (void)animateIn {
	self.endFrame = self.frame;
	CGFloat scale = 0.001f;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	[UIView beginAnimations:@"animateIn" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.075];
	[UIView setAnimationDidStopSelector:@selector(animateInStepTwo)];
	[UIView setAnimationDelegate:self];
	scale = 1.1;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	[UIView commitAnimations];
}

- (void)animateInStepTwo {
	[UIView beginAnimations:@"animateInStepTwo" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDidStopSelector:@selector(animateInStepThree)];
	[UIView setAnimationDelegate:self];
	
	CGFloat scale = 0.95;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	
	[UIView commitAnimations];
}

- (void)animateInStepThree {
	[UIView beginAnimations:@"animateInStepThree" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.075];
	
	CGFloat scale = 1.0;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	
	[UIView commitAnimations];
}

- (void)didMoveToSuperview {
	[self adjustMapRegionIfNeeded];
//	[self animateIn];
}

- (CGFloat)relativeParentXPosition {
	CGPoint parentOrigin = [self.mapView convertPoint:self.parentAnnotationView.frame.origin 
											 fromView:self.parentAnnotationView.superview];
	return parentOrigin.x + self.offsetFromParent.x;
}

- (UIView *)contentView {
	if (!_contentView) {
		_contentView = [[UIView alloc] init];
		self.contentView.backgroundColor = [UIColor clearColor];
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.contentView.userInteractionEnabled = YES;
		[self addSubview:self.contentView];
	}
	return _contentView;
}

- (void)dealloc {
	self.parentAnnotationView = nil;
	self.mapView = nil;
	[_contentView release];
    [super dealloc];
}

@end