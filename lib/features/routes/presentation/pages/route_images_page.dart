import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/features/routes/domain/entities/image.dart'
    as entities;
import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RouteImagesPage extends StatefulWidget {
  final List<entities.Image> images;

  const RouteImagesPage({super.key, required this.images});

  @override
  State<RouteImagesPage> createState() => _RouteImagesPageState();
}

class _RouteImagesPageState extends State<RouteImagesPage> {
  final TransformationController transformationController =
      TransformationController();

  TapDownDetails doubleTapDetails = TapDownDetails();

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnContent = [];
    for (int i = 0; i < widget.images.length; i++) {
      columnContent.add(
        Center(
          child: CustomNetworkImage(
            widget.images.reversed.elementAt(i).url,
            loadingColor: AppTheme.of(context).colorTheme.onSecondary,
          ),
        ),
      );
      if (i != widget.images.length - 1) {
        columnContent.add(const SizedBox(height: 8));
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.of(context).colorTheme.secondary,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onDoubleTapDown: (details) => doubleTapDetails = details,
              onDoubleTap: onDoubleTap,
              child: LayoutBuilder(
                builder: (context, constraints) => InteractiveViewer(
                  transformationController: transformationController,
                  constrained: false,
                  maxScale: 4,
                  child: ConstrainedBox(
                    constraints: constraints.copyWith(
                      minHeight: constraints.maxHeight,
                      maxHeight: double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: columnContent,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 16,
              left: 16,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  void onDoubleTap() {
    if (transformationController.value != Matrix4.identity()) {
      transformationController.value = Matrix4.identity();
    } else {
      final position = doubleTapDetails.localPosition;
      transformationController.value = Matrix4.identity()
        // For a 3x zoom
        // ..translate(-position.dx * 2, -position.dy * 2)
        // ..scale(3.0);
        // Fox a 2x zoom
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }
}
