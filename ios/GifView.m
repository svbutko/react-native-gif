#import "GifView.h"
#import <SDWebImage/SDWebImage.h>
#import "CustomActivityIndicator.h"

@implementation GifView {

    SDAnimatedImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
      _imageView = [SDAnimatedImageView new];
      [self playFadeIn];
  }
  return self;
}

- (void)layoutSubviews
{
    if (![_imageView superview]) {
        _imageView.frame = self.bounds;
        [self addSubview:_imageView];
        [self reloadImage];
    } else {
        _imageView.frame = self.bounds;
    }
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

        [self playFadeIn];

        [_imageView sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageProgressiveLoad context:@{SDWebImageContextImageThumbnailPixelSize : @(thumbnailSize)} progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

            if(self->_onLoadEnd) {
                self->_onLoadEnd(@{});
            }
        }];

    }
}

- (void)playFadeIn
{
    if(_fadeIn) {
        _imageView.sd_imageTransition = SDWebImageTransition.fadeTransition;
        _imageView.sd_imageTransition.duration = _fadeInDuration;
        _imageView.shouldIncrementalLoad = YES;
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

- (void)setFadeInDuration:(double)fadeInDuration
{
    if(_fadeInDuration != fadeInDuration) {
        _fadeInDuration = fadeInDuration;
    }
}


- (void)setPlaceholderUrl:(NSString *)placeholderUrl
{
  if (![placeholderUrl isEqual:_placeholderUrl]) {
      _placeholderUrl = [placeholderUrl copy];
      [self reloadImage];
  }
}

- (void)setFadeIn:(BOOL)fadeIn
{   
    _fadeIn = fadeIn;
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

        if (showLoadingIndicator) {
            _imageView.sd_imageIndicator = [[CustomActivityIndicator alloc] init];
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
