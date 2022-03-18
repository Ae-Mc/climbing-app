import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_bloc_builder.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_event.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_single_result.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    final colorTheme = AppTheme.of(context).colorTheme;

    return SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
      onSingleResult: (context, singleResult) => singleResult.maybeWhen(
        logoutSucceed: () =>
            AutoTabsRouter.of(context).navigate(const RoutesRouter()),
        // TODO: add error handling with toasts
        orElse: () => GetIt.I<CustomToast>(param1: context)
            .showTextFailureToast('Unexpected error: $singleResult'),
      ),
      builder: (context, state) => state.maybeWhen(
        orElse: () => const Center(child: CircularProgressIndicator.adaptive()),
        authorized: (user) => SingleChildScrollView(
          padding: const Pad(all: 16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: textTheme.title,
                  ),
                  Text('@${user.username}', style: textTheme.caption),
                  Text('Email: ${user.email}', style: textTheme.subtitle1),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Ink(
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: colorTheme.secondary,
                  ),
                  child: IconButton(
                    onPressed: () => BlocProvider.of<UserBloc>(context)
                        .add(const UserEvent.logout()),
                    icon: const Icon(Icons.logout),
                    color: colorTheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
