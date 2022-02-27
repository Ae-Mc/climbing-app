import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_bloc_builder.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_event.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_single_result.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_state.dart';
import 'package:climbing_app/features/routes/presentation/widgets/failure_widget.dart';
import 'package:climbing_app/features/routes/presentation/widgets/routes_list.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I<RoutesBloc>()..add(const RoutesBlocEvent.loadRoutes()),
      child: SingleResultBlocBuilder<RoutesBloc, RoutesBlocState,
          RoutesBlocSingleResult>(
        onSingleResult: (context, result) => showFailureToast(context, result),
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: state.map<Widget>(
                connectionFailure: (_) => FailureWidget(
                  title: 'Нет подключения к интернету',
                  body: 'Посмотрите настройки интернета и попробуйте еще раз',
                  onRetry: () => BlocProvider.of<RoutesBloc>(context)
                      .add(const RoutesBlocEvent.loadRoutes()),
                ),
                loaded: (state) => RoutesList(routes: state.routes),
                loading: (_) => const CircularProgressIndicator.adaptive(),
                serverFailure: (state) => FailureWidget(
                  title:
                      'Упс! Сервер вернул неожиданный код ответа: ${state.serverFailure.statusCode}',
                ),
                unknownFailure: (_) => const FailureWidget(
                  title: 'Упс! Произошла неожиданная ошибка!',
                  body: 'Пожалуйста, свяжитесь с разработчиком',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showFailureToast(BuildContext context, RoutesBlocSingleResult result) {
    void showToast(String text) {
      GetIt.I<FToast>(param1: context).showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            color: AppTheme.of(context).colorTheme.error,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: AppTheme.of(context).colorTheme.onError,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: AppTheme.of(context)
                    .textTheme
                    .body1Regular
                    .copyWith(color: AppTheme.of(context).colorTheme.onError),
              ),
            ],
          ),
        ),
      );
    }

    result.when<void>(
      connectionFailure: () => showToast('Ошибка соединения'),
      serverFailure: (state) =>
          showToast('Ошибка сервера: ${state.statusCode}'),
      unknownFailure: () => showToast('Неизвестная ошибка'),
    );
  }
}
