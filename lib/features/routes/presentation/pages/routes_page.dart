import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_bloc_builder.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_event.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_single_result.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_state.dart';
import 'package:climbing_app/features/routes/presentation/widgets/failure_widget.dart';
import 'package:climbing_app/features/routes/presentation/widgets/routes_list.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({Key? key}) : super(key: key);

  void loadRoutes(BuildContext context) => BlocProvider.of<RoutesBloc>(context)
      .add(const RoutesBlocEvent.loadRoutes());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I<RoutesBloc>()..add(const RoutesBlocEvent.loadRoutes()),
      child: SingleResultBlocBuilder<RoutesBloc, RoutesBlocState,
          RoutesBlocSingleResult>(
        onSingleResult: (context, result) => showFailureToast(context, result),
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async => loadRoutes(context),
            child: Center(
              child: state.map<Widget>(
                connectionFailure: (_) => FailureWidget(
                  title: 'Нет подключения к интернету',
                  body: 'Посмотрите настройки интернета и попробуйте еще раз',
                  onRetry: () => loadRoutes(context),
                ),
                loaded: (state) => RoutesList(routes: state.routes),
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
      ),
    );
  }

  void showFailureToast(BuildContext context, RoutesBlocSingleResult result) {
    final customToast = CustomToast(context);

    result.when<void>(
      connectionFailure: () =>
          customToast.showTextFailureToast('Ошибка соединения'),
      serverFailure: (state) => customToast
          .showTextFailureToast('Ошибка сервера: ${state.statusCode}'),
      unknownFailure: () =>
          customToast.showTextFailureToast('Неизвестная ошибка'),
    );
  }
}
