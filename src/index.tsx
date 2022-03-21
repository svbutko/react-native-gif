import React from 'react';
import {
  Image,
  ImageResizeMode,
  Platform,
  requireNativeComponent,
} from 'react-native';

type GifProps = {
  source: string;
  style: any;
  resizeMode: ImageResizeMode;
  placeholderUrl?: string;
  paused: boolean;
  onLoadEnd?: () => void;
  useCPU?: boolean;
  quality?: number;
};

export const GifViewManager = requireNativeComponent<GifProps>('GifImage');

const GifImage = (props: {
  source: { uri: string };
  style: any;
  resizeMode: ImageResizeMode;
  paused?: boolean;
  onLoadEnd?: () => void;
  placeholderUrl?: string;
  useCPU?: boolean;
  quality?: number;
}) => {
  const {
    style,
    source,
    resizeMode,
    paused = false,
    onLoadEnd,
    useCPU = false,
    quality = 1,
    placeholderUrl,
  } = props;
  const relovedSource = Image.resolveAssetSource(source);
  return Platform.OS === 'ios' ? (
    <GifViewManager
      style={style}
      source={relovedSource.uri}
      resizeMode={resizeMode}
      paused={paused}
      onLoadEnd={onLoadEnd}
      placeholderUrl={placeholderUrl}
      useCPU={useCPU}
      quality={quality}
    />
  ) : (
    <Image {...props} />
  );
};

export default GifImage;
