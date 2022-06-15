import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/features/routes/domain/entities/image.dart'
    as entities;
import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class RouteImagesPage extends StatelessWidget {
  final List<entities.Image> images;

  const RouteImagesPage({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnContent = [];
    for (int i = 0; i < images.length; i++) {
      columnContent.add(
        Center(
          child: CustomNetworkImage(
            images.reversed.elementAt(i).url,
            loadingColor: AppTheme.of(context).colorTheme.onSecondary,
          ),
        ),
      );
      if (i != images.length - 1) {
        columnContent.add(const SizedBox(height: 8));
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.of(context).colorTheme.secondary,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return InteractiveViewer(
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
                );
              },
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
}
