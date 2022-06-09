import React, { FC, ReactNode } from 'react';
import {
  Image,
  ImageResizeMode,
  ImageStyle,
  ImageURISource,
  Platform,
  requireNativeComponent,
} from 'react-native';

interface IGifProps {
  source: ImageURISource;
  resizeMode: ImageResizeMode;
  paused?: boolean;
  style?: ImageStyle;
  placeholderUrl?: string;
  onLoadEnd?: () => void;
  useCPU?: boolean;
  quality?: number;
  showLoadingIndicator?: boolean;
  children?: ReactNode;
}

const GifViewManager = requireNativeComponent<IGifProps>('GifImage');

const GifComponent = Platform.OS === 'ios' ? GifViewManager : Image;

const GifImage: FC<IGifProps> = (props) => {
  return <GifComponent {...props} />;
};

GifImage.defaultProps = {
  paused: false,
  useCPU: false,
  showLoadingIndicator: false,
  quality: 1,
};

export default GifImage;
