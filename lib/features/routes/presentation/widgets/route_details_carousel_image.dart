import 'package:flutter/material.dart';

class RouteDetailsCarouselImage extends StatefulWidget {
  final String imageUrl;

  const RouteDetailsCarouselImage({Key? key, required this.imageUrl})
      : super(key: key);

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
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          image: DecorationImage(
            image: NetworkImage(
              'http://192.168.1.56:8000/${widget.imageUrl}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
