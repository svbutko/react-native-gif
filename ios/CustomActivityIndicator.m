#import "CustomActivityIndicator.h"
#import "CustomViewContainer.h"

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
    self.indicatorView = [[CustomViewContainer alloc] init];
}

- (void)startAnimatingIndicator {
    self.indicatorView.hidden = NO;
}

- (void)stopAnimatingIndicator {
    self.indicatorView.hidden = YES;
}

@end

