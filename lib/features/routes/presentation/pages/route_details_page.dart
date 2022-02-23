import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:flutter/material.dart' hide Route;

class RouteDetailsPage extends StatelessWidget {
  final Route route;

  const RouteDetailsPage({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const Pad(all: 16),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppTheme.of(context).colorTheme.onBackground,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              AppTheme.of(context).colorTheme.background,
                            ),
                            padding: MaterialStateProperty.all(Pad.zero),
                          ),
                          onPressed: () => AutoRouter.of(context).pop(),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: AppTheme.of(context).colorTheme.background,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'asodjoa aosjdojow amdklando j1on',
                            textAlign: TextAlign.center,
                            style: AppTheme.of(context).textTheme.title,
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                  if (route.images.isNotEmpty)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Padding(
                          padding: const Pad(bottom: 16),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              aspectRatio: 1,
                              viewportFraction: (constraints.maxWidth - 32) /
                                  constraints.maxWidth,
                              enlargeCenterPage: true,
                              autoPlay: true,
                            ),
                            items: route.images
                                .map(
                                  (e) => SizedBox.expand(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      child: Image.network(
                                        'http://192.168.1.56:8000/${e.url}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    ),
                  Padding(
                    padding: const Pad(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          route.description,
                          style: AppTheme.of(context).textTheme.body1Regular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const Pad(vertical: 16),
                  child: ElevatedButton(
                    onPressed: routeCompleted,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const Pad(vertical: 16, horizontal: 64),
                      ),
                    ),
                    child: const Text('Я пролез трассу'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void routeCompleted() {
    // TODO
  }
}
