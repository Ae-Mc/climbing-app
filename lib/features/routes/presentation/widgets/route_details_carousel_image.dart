import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class RouteDetailsCarouselImage extends StatefulWidget {
  final String imageUrl;

  const RouteDetailsCarouselImage({super.key, required this.imageUrl});

  @override
  State<RouteDetailsCarouselImage> createState() =>
      _RouteDetailsCarouselImageState();
}

class _RouteDetailsCarouselImageState extends State<RouteDetailsCarouselImage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid-ignoring-return-values
    super.build(context);

    return AspectRatio(
      aspectRatio: 1,
      child: CustomNetworkImage(
        widget.imageUrl,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
