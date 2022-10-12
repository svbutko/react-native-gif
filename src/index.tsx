import React, { FC, ReactNode } from 'react';
import {
  Image,
  ImageLoadEventData,
  ImageProps,
  ImageStyle,
  ImageURISource,
  NativeSyntheticEvent,
  Platform,
  requireNativeComponent,
} from 'react-native';

export interface GifImageProps extends Omit<ImageProps, 'onLoadEnd'> {
  source: ImageURISource;
  resizeMode: 'cover' | 'contain';
  paused?: boolean;
  style?: ImageStyle;
  placeholderUrl?: string;
  onLoadEnd?: (e?: NativeSyntheticEvent<ImageLoadEventData>) => void;
  useCPU?: boolean;
  fadeIn?: boolean;
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
};

export default GifImage;
