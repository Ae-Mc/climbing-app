import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    final colorTheme = AppTheme.of(context).colorTheme;
    const cardBorderRadius = BorderRadius.all(Radius.circular(16));

    return Scaffold(
      body: SafeArea(
        child: SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
          onSingleResult: (context, singleResult) => switch (singleResult) {
            UserSingleResultSuccess() => AutoRouter.of(context).popUntilRoot(),
            UserSingleResultFailure(:final failure) =>
              CustomToast(context).showTextFailureToast(failureToText(failure)),
            _ => GetIt.I<Logger>().d('Unexpected error: $singleResult'),
          },
          builder: (context, state) => switch (state) {
            UserStateAuthorized(:final activeUser) => ListView(
                padding: const Pad(all: 16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomBackButton(),
                      Expanded(
                        child: Text(
                          'Профиль',
                          style: textTheme.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      width: 144,
                      height: 144,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(
                          side: BorderSide(color: colorTheme.primary, width: 4),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(72)),
                        child: Assets.icons.climber.svg(fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${activeUser.firstName} ${activeUser.lastName}',
                    style: textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: cardBorderRadius,
                    ),
                    child: InkWell(
                      onTap: () =>
                          AutoRouter.of(context).push(const MyRoutesRoute()),
                      borderRadius: cardBorderRadius,
                      child: Padding(
                        padding: const Pad(all: 24),
                        child: Text(
                          'Загруженные трассы',
                          style: textTheme.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => BlocProvider.of<UserBloc>(context)
                        .add(const UserEvent.signOut()),
                    child: const Text(
                      'Выйти',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            _ => const Center(child: CustomProgressIndicator()),
          },
        ),
      ),
    );
  }
}
