import React, { FC, ReactNode } from 'react';
import {
  Image,
  ImageLoadEventData,
  ImageProps,
  ImageURISource,
  NativeSyntheticEvent,
  Platform,
  requireNativeComponent,
} from 'react-native';

export interface GifImageProps
  extends Omit<ImageProps, 'onLoadEnd' | 'fadeDuration'> {
  source: ImageURISource;
  resizeMode: 'cover' | 'contain';
  paused?: boolean;
  style?: ImageProps['style'];
  placeholderUrl?: string;
  onLoadEnd?: (e?: NativeSyntheticEvent<ImageLoadEventData>) => void;
  useCPU?: boolean;
  fadeIn?: boolean;
  fadeInDuration?: number;
  quality?: number;
  showLoadingIndicator?: boolean;
  children?: ReactNode;
}

const GifViewManager = requireNativeComponent<GifImageProps>('GifImage');

const GifComponent = Platform.OS === 'ios' ? GifViewManager : Image;

const GifImage: FC<GifImageProps> = (props) => {
  return <GifComponent {...props} />;
};

GifImage.defaultProps = {
  paused: false,
  useCPU: false,
  showLoadingIndicator: false,
  fadeIn: true,
  quality: 1,
  fadeInDuration: 0.15,
};

export default GifImage;
