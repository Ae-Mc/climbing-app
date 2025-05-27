import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/app/theme/models/app_color_theme.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final int? cacheSize;

  /// If [null] uses [AppColorTheme.primary]
  final Color? loadingColor;

  const CustomNetworkImage(
    this.url, {
    super.key,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.loadingColor,
    this.width,
    this.height,
    this.cacheSize,
  });

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  Orientation? orientation;
  @override
  Widget build(BuildContext context) {
    final localCacheSize = widget.cacheSize;
    final orientation = this.orientation;
    int? deviceCacheSize, deviceCacheWidth, deviceCacheHeight;
    if (localCacheSize != null && orientation != null) {
      final pixelRatio = MediaQuery.of(context).devicePixelRatio;
      deviceCacheSize = (localCacheSize * pixelRatio).round();
      switch (orientation) {
        case Orientation.landscape:
          deviceCacheHeight = deviceCacheSize;
        case Orientation.portrait:
          deviceCacheWidth = deviceCacheSize;
      }
    }
    // TODO: fix image caching
    final baseProvider = ExtendedNetworkImageProvider(
      widget.url,
      cache: true,
      cacheRawData: false,
    );
    late final ImageProvider imageProvider;
    if (deviceCacheWidth != null || deviceCacheHeight != null) {
      imageProvider = ExtendedResizeImage(
        baseProvider,
        width: deviceCacheWidth,
        height: deviceCacheHeight,
        policy: ResizeImagePolicy.fit,
        allowUpscaling: true,
        maxBytes: 50 << 10,
        cacheRawData: false,
      );
    } else {
      imageProvider = baseProvider;
    }
    return ExtendedImage(
      image: imageProvider,
      loadStateChanged: (state) => onLoadStateChanged(state, context),
      shape: BoxShape.rectangle,
      borderRadius: widget.borderRadius,
      fit: widget.fit,
      handleLoadingProgress: true,
      width: widget.width,
      height: widget.height,
      clearMemoryCacheWhenDispose: true,
    );
  }

  Widget? onLoadStateChanged(ExtendedImageState state, BuildContext context) {
    final expectedTotalBytes = state.loadingProgress?.expectedTotalBytes;
    final loadingProgress = state.loadingProgress;
    final primaryColor = AppTheme.of(context).colorTheme.primary;
    final loadState = state.extendedImageLoadState;

    switch (loadState) {
      case LoadState.completed:
        if (orientation == null) {
          final imageInfo = state.extendedImageInfo;
          if (imageInfo == null) {
            throw AssertionError("imageInfo == null");
          }
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            setState(() {
              if (imageInfo.image.width > imageInfo.image.height) {
                orientation = Orientation.landscape;
              } else {
                orientation = Orientation.portrait;
              }
            });
            final imageSize =
                (await (state.imageProvider as ExtendedNetworkImageProvider)
                    .imageCache
                    .currentSizeBytes);
            print('${widget.url}: $orientation, size: $imageSize/null');
          });
        }
        return state.completedWidget;
      case _:
        return Center(
          child: expectedTotalBytes == null
              ? CustomProgressIndicator(
                  color: widget.loadingColor ?? primaryColor)
              : CustomProgressIndicator(
                  value: loadingProgress!.cumulativeBytesLoaded /
                      expectedTotalBytes,
                  color: widget.loadingColor ?? primaryColor,
                ),
        );
    }
  }
}
