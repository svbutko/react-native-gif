#import "CustomActivityIndicator.h"

@interface CustomActivityIndicator ()
@property (nonatomic, strong, readwrite, nonnull) UIView *indicatorView;
@end

@implementation CustomActivityIndicator

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UIView *container = [[UIView alloc] init];

    UIColor *backgroundColor = [UIColor colorWithRed:50.0 / 255.0 green:46.0 / 255.0 blue:77.0 / 255.0 alpha:1];
    CGFloat circleColorValue = 239.0 / 255.0;
    UIColor *circleColor = [UIColor colorWithRed:circleColorValue green:circleColorValue blue:circleColorValue alpha:1];

    [container setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [container setBackgroundColor:backgroundColor];

    CAShapeLayer *circleLayer = [CAShapeLayer layer];

    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 25, 25)] CGPath]];
    [circleLayer setStrokeColor:[circleColor CGColor]];
    [circleLayer setFillColor:[backgroundColor CGColor]];
    [circleLayer setLineWidth:2.0];

    [[container layer] addSublayer:circleLayer];

    self.indicatorView = container;
}

- (void)startAnimatingIndicator {
    self.indicatorView.hidden = NO;
}

- (void)stopAnimatingIndicator {
    self.indicatorView.hidden = YES;
}

@end

