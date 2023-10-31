import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/routes/presentation/widgets/routes_list.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class MyRoutesPage extends StatelessWidget {
  const MyRoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
          onSingleResult: (context, singleResult) => singleResult.whenOrNull(
            failure: (failure) => CustomToast(context)
                .showTextFailureToast(failureToText(failure)),
          ),
          builder: (context, state) => state.when(
            authorized: (activeUser, allUsers, userRoutes) => RoutesList(
              headerSliverBuilder: (context) => CustomSliverAppBar(
                text: 'Загруженные трассы',
                leadingBuilder: (context) => const BackButton(),
              ),
              routes: userRoutes,
            ),
            initializationFailure: (_) =>
                throw UnimplementedError('Impossible state'),
            loading: () => const Center(child: CustomProgressIndicator()),
            notAuthorized: () => throw UnimplementedError('Impossible state'),
          ),
        ),
      ),
    );
  }
}
