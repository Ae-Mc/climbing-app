import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/category_to_color.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc.dart';
import 'package:climbing_app/features/routes/presentation/widgets/custom_table_row.dart';
import 'package:climbing_app/features/routes/presentation/widgets/route_details_carousel_image.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:single_result_bloc/single_result_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class RouteDetailsPage extends StatefulWidget {
  final Route route;

  const RouteDetailsPage({super.key, required this.route});

  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleResultBlocBuilder<RoutesBloc, RoutesBlocState,
            RoutesBlocSingleResult>(
          onSingleResult: (context, singleResult) =>
              handleSingleResult(context, singleResult),
          buildWhen: (previous, current) => false,
          builder: (_, __) => CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Padding(
                      padding: const Pad(all: 16),
                      child: Row(
                        children: [
                          const CustomBackButton(),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.route.name,
                              textAlign: TextAlign.center,
                              style: AppTheme.of(context).textTheme.title,
                              maxLines: 3,
                            ),
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) => SizedBox(
                              width: CustomBackButton.iconSize,
                              height: CustomBackButton.iconSize,
                              child: state.whenOrNull(
                                authorized: (activeUser, _, __) =>
                                    (activeUser.id == widget.route.author.id)
                                        ? IconButton(
                                            padding: Pad.zero,
                                            onPressed: () =>
                                                AutoRouter.of(context).push(
                                                    UpdateRouteRoute(
                                                        route: widget.route)),
                                            icon: const Icon(
                                              Icons.edit_rounded,
                                            ),
                                            iconSize: CustomBackButton.iconSize,
                                          )
                                        : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.route.images.isNotEmpty) ...[
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            height: constraints.maxWidth - 32,
                            child: Material(
                              color: AppTheme.of(context).colorTheme.background,
                              child: PageView.builder(
                                controller: pageController,
                                itemBuilder: (context, index) => Padding(
                                  padding: const Pad(horizontal: 16),
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    onTap: () =>
                                        AutoRouter.of(context).navigate(
                                      RouteImagesRoute(
                                        images: widget.route.images,
                                      ),
                                    ),
                                    child: RouteDetailsCarouselImage(
                                      imageUrl: widget
                                          .route
                                          .images[index %
                                              widget.route.images.length]
                                          .url,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: widget.route.images.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor:
                                AppTheme.of(context).colorTheme.secondary,
                            dotColor:
                                AppTheme.of(context).colorTheme.unselected,
                            dotHeight: 6,
                            dotWidth: 6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Padding(
                      padding: const Pad(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: FixedColumnWidth(30),
                              2: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              CustomTableRow(
                                context: context,
                                rowHeader: 'Цвет меток',
                                rowValue: widget.route.markColor,
                              ),
                              CustomTableRow(
                                context: context,
                                rowHeader: 'Категория',
                                rowValue: widget.route.category.toString(),
                                chipBackgroundColor: categoryToColor(
                                  widget.route.category,
                                  AppTheme.of(context).colorTheme,
                                ),
                              ),
                              CustomTableRow(
                                context: context,
                                rowHeader: 'Автор',
                                rowValue:
                                    '${widget.route.author.lastName} ${widget.route.author.firstName}',
                              ),
                              CustomTableRow(
                                context: context,
                                rowHeader: 'Создано',
                                rowValue: DateFormat.yMd('ru')
                                    .format(widget.route.creationDate),
                              ),
                            ],
                          ),
                          if (widget.route.description.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              widget.route.description,
                              style:
                                  AppTheme.of(context).textTheme.body1Regular,
                              maxLines: 999,
                            ),
                          ],
                          const SizedBox(height: 16),
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
                    padding: const Pad(top: 16, bottom: 32),
                    child: ElevatedButton(
                      onPressed: () => AutoRouter.of(context)
                          .push(AddAscentRoute(route: widget.route)),
                      child: const Text('Я пролез трассу'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void handleSingleResult(
    BuildContext context,
    RoutesBlocSingleResult singleResult,
  ) {
    final toast = CustomToast(context);

    return singleResult.when<void>(
      failure: (failure) => toast.showTextFailureToast(failureToText(failure)),
      removeRouteSuccess: () {
        toast.showTextSuccessToast("Трасса успешно удалена!");
        BlocProvider.of<UserBloc>(context).add(const UserEvent.fetch());
        AutoRouter.of(context).pop(); // ignore: avoid-ignoring-return-values
      },
    );
  }
}
