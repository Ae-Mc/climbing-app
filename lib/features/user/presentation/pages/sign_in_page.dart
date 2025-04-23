import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/core/widgets/unexpected_behavior.dart';
import 'package:climbing_app/features/user/domain/entities/sign_in_failure.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/core/widgets/styled_password_field.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  final usernameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final void Function() onSuccessSignIn;

  SignInPage({super.key, required this.onSuccessSignIn});

  @override
  Widget build(BuildContext context) {
    return SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
      onSingleResult: onUserSingleResult,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: switch (state) {
              UserStateInitializationFailure() => const UnexpectedBehavior(),
              _ => SizedBox.expand(
                  child: Stack(
                    children: [
                      Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const Pad(all: 16),
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Assets.icons.logo.svg(
                                    colorFilter: ColorFilter.mode(
                                      AppTheme.of(context).colorTheme.secondary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Вход',
                                    style: AppTheme.of(context).textTheme.title,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  StyledTextField(
                                    controller: usernameOrEmailController,
                                    hintText: 'Имя пользователя или email',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 16),
                                  StyledPasswordField(
                                    controller: passwordController,
                                    hintText: 'Пароль',
                                  ),
                                  const SizedBox(height: 16),
                                  SubmitButton(
                                    isLoaded: state is! UserStateLoading,
                                    onPressed: () =>
                                        BlocProvider.of<UserBloc>(context).add(
                                      UserEvent.signIn(
                                        usernameOrEmailController.text,
                                        passwordController.text,
                                      ),
                                    ),
                                    text: 'Войти',
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton(
                                    onPressed: () =>
                                        AutoRouter.of(context).replace(
                                      RegisterRoute(
                                        onSuccessRegister: () => {},
                                        nextRoute: SignInRoute(
                                          onSuccessSignIn: onSuccessSignIn,
                                        ),
                                      ),
                                    ),
                                    child: const Text("Регистрация"),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton(
                                    onPressed: () =>
                                        AutoRouter.of(context).push(
                                      const ForgotPasswordRoute(),
                                    ),
                                    child: const Text("Сброс пароля"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 16,
                        left: 16,
                        child: CustomBackButton(),
                      ),
                    ],
                  ),
                )
            },
          ),
        );
      },
    );
  }

  void onUserSingleResult(BuildContext context, UserSingleResult singleResult) {
    final customToast = CustomToast(context);
    // ignore: avoid-ignoring-return-values
    switch (singleResult) {
      case UserSingleResultFailure(:final failure):
        customToast.showTextFailureToast(failureToText(failure));
      case UserSingleResultSignInFailure(:final signInFailure):
        customToast.showTextFailureToast(switch (signInFailure) {
          SignInFailureBadCredentials() => "Неверный логин или пароль",
          SignInFailureUserNotVerified() =>
            "Пользователь не прошёл верификацию",
          SignInFailureValidationError(:final text) => text,
        });
      case UserSingleResultSignIn():
        onSuccessSignIn();
        AutoRouter.of(context).maybePop();
      case _:
    }
  }
}
