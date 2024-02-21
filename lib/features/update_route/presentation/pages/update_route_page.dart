import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/util/pick_date.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc.dart';
import 'package:climbing_app/features/update_route/domain/entities/route_update.dart';
import 'package:climbing_app/features/update_route/domain/repositories/update_route_repository.dart';
import 'package:climbing_app/features/update_route/presentation/widgets/images_carousel.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class UpdateRoutePage extends StatefulWidget {
  final Route route;

  const UpdateRoutePage(this.route, {super.key});

  @override
  State<UpdateRoutePage> createState() => _UpdateRoutePageState();
}

class _UpdateRoutePageState extends State<UpdateRoutePage> {
  final nameController = TextEditingController();
  final marksColorController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final imagesCarouselController = ImagesCarouselController(images: []);
  late Category category;

  late bool archived;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.route.name;
    marksColorController.text = widget.route.markColor;
    dateController.text =
        GetIt.I<DateFormat>().format(widget.route.creationDate);
    categoryController.text = widget.route.category.name;
    descriptionController.text = widget.route.description;
    category = widget.route.category;
    archived = widget.route.archived;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    final colorTheme = AppTheme.of(context).colorTheme;
    final columnItems = [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(
          label: Text("Название трассы"),
          suffixIcon: Icon(Icons.abc),
        ),
      ),
      TextField(
        controller: marksColorController,
        decoration: const InputDecoration(
          label: Text("Цвет меток"),
          suffixIcon: Icon(Icons.color_lens_rounded),
        ),
      ),
      TextField(
        controller: dateController,
        decoration: const InputDecoration(
          label: Text("Дата постановки"),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => pickDate(context, dateController),
      ),
      SizedBox(
        width: double.infinity,
        child: DropdownMenu<Category>(
          controller: categoryController,
          onSelected: (value) => category = value ?? category,
          inputDecorationTheme: Theme.of(context).inputDecorationTheme,
          label: Text("Категория", style: textTheme.subtitle1),
          dropdownMenuEntries: Category.values
              .map(
                (category) =>
                    DropdownMenuEntry(value: category, label: category.name),
              )
              .toList(),
          expandedInsets: Pad.zero,
        ),
      ),
      TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          label: Text("Описание"),
        ),
        maxLines: 8,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
      ),
      CheckboxListTile.adaptive(
        value: archived,
        onChanged: (value) => setState(() => archived = value ?? archived),
        title: const Text('Архив'),
        contentPadding: Pad.zero,
      ),
    ];

    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          text: "Редактирование трассы",
          leading: BackButton(),
        ),
        SliverPadding(
          padding: const Pad(all: 16),
          sliver: SliverList.separated(
            itemBuilder: (context, index) => columnItems[index],
            itemCount: columnItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        ),
        SliverPadding(
          padding: const Pad(horizontal: 16, bottom: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Изображения",
              style: textTheme.subtitle1,
            ),
          ),
        ),
        SliverPadding(
          padding: const Pad(bottom: 16),
          sliver: SliverToBoxAdapter(
            child: ImagesCarousel(
              controller: imagesCarouselController,
              initialImages: widget.route.images,
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const Pad(horizontal: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleResultBlocBuilder<RoutesBloc, RoutesBlocState,
                  RoutesBlocSingleResult>(
                onSingleResult: (context, singleResult) =>
                    singleResult.when<void>(
                  removeRouteSuccess: () {
                    CustomToast(context).showTextSuccessToast("Трасса удалена");
                    refreshAndPop(context);
                  },
                  failure: (failure) => CustomToast(context)
                      .showTextFailureToast(failureToText(failure)),
                ),
                builder: (context, state) => SubmitButton(
                  color: colorTheme.error,
                  text: "Удалить",
                  isLoaded:
                      state.maybeMap(loading: (_) => false, orElse: () => true),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        content: const Text("Удалить трассу?"),
                        actions: [
                          TextButton(
                            onPressed: () => context.router.pop(false),
                            child: Text(
                              "Отмена",
                              style: TextStyle(color: colorTheme.primary),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.router.pop(true),
                            child: Text(
                              "Да",
                              style: TextStyle(color: colorTheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ).then((value) {
                      if (value == true) {
                        BlocProvider.of<RoutesBloc>(context)
                            .add(RoutesBlocEvent.removeRoute(widget.route));
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              SubmitButton(
                text: "Обновить",
                isLoaded: true,
                onPressed: () => GetIt.I<UpdateRouteRepository>()
                    .updateRoute(
                      widget.route.id,
                      RouteUpdate(
                        category: category,
                        creationDate: dateController.text,
                        description: descriptionController.text,
                        images: imagesCarouselController.images,
                        markColor: marksColorController.text,
                        name: nameController.text,
                        archived: archived,
                      ),
                    )
                    .then(
                      (value) => value.fold(
                        (l) {
                          GetIt.I<Logger>().e(l);
                          CustomToast(context)
                              .showTextFailureToast(failureToText(l));
                        },
                        (r) {
                          refreshAndPop(context);
                          AutoRouter.of(context)
                              .push(RouteDetailsRoute(route: r));
                        },
                      ),
                    ),
              ),
            ],
          ),
        )),
      ],
    )));
  }

  void refreshAndPop(BuildContext context) {
    BlocProvider.of<RoutesBloc>(context)
        .add(const RoutesBlocEvent.loadRoutes());
    BlocProvider.of<UserBloc>(context).add(const UserEvent.fetch());
    String? previousRouteName;
    AutoRouter.of(context).popUntil(
      (route) {
        final result = previousRouteName == RouteDetailsRoute.name;
        previousRouteName = route.settings.name;
        return result;
      },
    );
  }
}
