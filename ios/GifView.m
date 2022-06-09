#import "GifView.h"
#import <SDWebImage/SDWebImage.h>

@implementation GifView {

    SDAnimatedImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
      _imageView = [SDAnimatedImageView new];

      _imageView.sd_imageTransition = SDWebImageTransition.fadeTransition;
      _imageView.sd_imageTransition.duration = 0.4;
      _imageView.shouldIncrementalLoad = YES;
  }
  return self;
}

- (void)layoutSubviews
{
    _imageView.frame = self.bounds;

    [self addSubview:_imageView];
    [self reloadImage];
}

- (void) reloadImage {
    if(_source && self.frame.size.width > 0 && _quality) {
        NSURL *url = [NSURL URLWithString:_source];

        CGFloat scale = UIScreen.mainScreen.scale;
        CGSize thumbnailSize = CGSizeMake(self.frame.size.width * scale * _quality, self.frame.size.height * scale * _quality);
        UIImage *placeholderImage = nil;
        if(_placeholderUrl != nil) {
            NSURL *placeholderUrl = [NSURL URLWithString:_placeholderUrl];
            NSData *data = [NSData dataWithContentsOfURL:placeholderUrl];
            placeholderImage = [[UIImage alloc] initWithData:data];
        }

        _imageView.sd_imageTransition = SDWebImageTransition.fadeTransition;
        _imageView.sd_imageTransition.duration = 0.4;
        _imageView.shouldIncrementalLoad = YES;

        [_imageView sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageProgressiveLoad context:@{SDWebImageContextImageThumbnailPixelSize : @(thumbnailSize)} progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

            if(self->_onLoadEnd) {
                self->_onLoadEnd(@{});
            }
        }];

    }
}


- (void)setSource:(NSDictionary *)source
{
    NSString *uri = [source objectForKey:@"uri"];
  if (![uri isEqual:_source]) {
      _source = [uri copy];
      [self reloadImage];
  }
}


- (void)setPlaceholderUrl:(NSString *)placeholderUrl
{
  if (![placeholderUrl isEqual:_placeholderUrl]) {
      _placeholderUrl = [placeholderUrl copy];
      [self reloadImage];
  }
}



- (void)setResizeMode:(NSString *)resizeMode
{
  if (![resizeMode isEqual:_resizeMode]) {
      _resizeMode = [resizeMode copy];

      if([_resizeMode isEqualToString:@"contain"]) {
          _imageView.contentMode = UIViewContentModeScaleAspectFit;
      } else if ([_resizeMode isEqualToString:@"cover"]) {
          _imageView.contentMode = UIViewContentModeScaleAspectFill;
      }
  }
}

- (void)setShowLoadingIndicator:(BOOL *)showLoadingIndicator
{
    if(showLoadingIndicator != _showLoadingIndicator) {
        _showLoadingIndicator = showLoadingIndicator;

        SDWebImageActivityIndicator* loadingIndicator = [[SDWebImageActivityIndicator alloc] init];
        loadingIndicator.indicatorView.color = [UIColor whiteColor];
        loadingIndicator.indicatorView.backgroundColor = [UIColor colorWithRed:50.0 green:46.0 blue:77.0 alpha:1.0];

        if (showLoadingIndicator) {
            _imageView.sd_imageIndicator = loadingIndicator;
        } else {
            _imageView.sd_imageIndicator = nil;
        }
    }
}

- (void)setPaused:(BOOL *)paused
{
    if(paused != _paused) {
        _paused = paused;
        if(paused) {
            [_imageView stopAnimating];
        } else {
            [_imageView startAnimating];
        }
    }
}

- (void)setOnLoadEnd:(RCTDirectEventBlock)onLoadEnd {
    if (![onLoadEnd isEqual:_onLoadEnd]) {
        _onLoadEnd = [onLoadEnd copy];
        [self reloadImage];
    }
}

- (void)setUseCPU:(BOOL)useCPU
{
    if (_useCPU != useCPU) {
        _useCPU = useCPU;
        if (useCPU) {
            _imageView.maxBufferSize = 1;
        }
    }
}

- (void)setQuality:(double)quality
{
    _quality = quality;
    [self reloadImage];
}

@end
