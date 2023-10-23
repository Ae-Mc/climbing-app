import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc.dart';
import 'package:climbing_app/features/routes/presentation/widgets/failure_widget.dart';
import 'package:climbing_app/features/routes/presentation/widgets/routes_list.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class RoutesPage extends StatelessWidget {
  const RoutesPage({super.key});

  void loadRoutes(BuildContext context) => BlocProvider.of<RoutesBloc>(context)
      .add(const RoutesBlocEvent.loadRoutes());

  @override
  Widget build(BuildContext context) {
    return SingleResultBlocBuilder<RoutesBloc, RoutesBlocState,
        RoutesBlocSingleResult>(
      onSingleResult: (context, result) => handleSingleResult(context, result),
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => loadRoutes(context),
          child: Center(
            child: state.map<Widget>(
              connectionFailure: (_) => FailureWidget(
                title: 'Нет подключения к интернету',
                body: 'Проверьте настройки интернета и попробуйте еще раз',
                onRetry: () => loadRoutes(context),
              ),
              loaded: (state) => RoutesList(
                routes: state.routes,
                headerSliverBuilder: (context) =>
                    const CustomSliverAppBar(text: "Трассы"),
              ),
              loading: (_) => const CustomProgressIndicator(),
              serverFailure: (state) => FailureWidget(
                title:
                    'Упс! Сервер вернул неожиданный код ответа: ${state.serverFailure.statusCode}',
                onRetry: () => loadRoutes(context),
              ),
              unknownFailure: (_) => FailureWidget(
                title: 'Упс! Произошла неожиданная ошибка!',
                body: 'Пожалуйста, свяжитесь с разработчиком',
                onRetry: () => loadRoutes(context),
              ),
            ),
          ),
        );
      },
    );
  }

  void handleSingleResult(BuildContext context, RoutesBlocSingleResult result) {
    final customToast = CustomToast(context);
    final text = result.when<String?>(
      failure: failureToText,
      removeRouteSuccess: () => null,
    );

    if (text != null) {
      customToast.showTextFailureToast(text);
    }
  }
}
