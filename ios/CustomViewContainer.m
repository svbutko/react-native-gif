#import "CustomViewContainer.h"

@interface CustomViewContainer ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@end

@implementation CustomViewContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UIColor *backgroundColor = [UIColor colorWithRed:50.0 / 255.0 green:46.0 / 255.0 blue:77.0 / 255.0 alpha:1];
    CGFloat circleColorValue = 239.0 / 255.0;
    UIColor *circleColor = [UIColor colorWithRed:circleColorValue green:circleColorValue blue:circleColorValue alpha:1];

    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self setBackgroundColor:backgroundColor];
    _circleLayer = [CAShapeLayer layer];
    [_circleLayer setStrokeColor:[circleColor CGColor]];
    [_circleLayer setFillColor:[backgroundColor CGColor]];
    [_circleLayer setLineWidth:2.0];
    [_circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-25 / 2, -25 / 2, 25, 25)] CGPath]];

    [self.layer addSublayer:_circleLayer];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    _circleLayer.position = self.center;
}

@end

