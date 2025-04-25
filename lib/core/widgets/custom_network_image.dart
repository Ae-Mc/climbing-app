import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/app/theme/models/app_color_theme.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

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
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      loadStateChanged: (state) => onLoadStateChanged(state, context),
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      fit: fit,
      handleLoadingProgress: true,
      width: width,
      height: height,
      clearMemoryCacheWhenDispose: true,
    );
  }

  Widget? onLoadStateChanged(ExtendedImageState state, BuildContext context) {
    final expectedTotalBytes = state.loadingProgress?.expectedTotalBytes;
    final loadingProgress = state.loadingProgress;
    final primaryColor = AppTheme.of(context).colorTheme.primary;

    return loadingProgress == null
        ? state.completedWidget
        : Center(
            child: expectedTotalBytes == null
                ? CustomProgressIndicator(color: loadingColor ?? primaryColor)
                : CustomProgressIndicator(
                    value: loadingProgress.cumulativeBytesLoaded /
                        expectedTotalBytes,
                    color: loadingColor ?? primaryColor,
                  ),
          );
  }
}
