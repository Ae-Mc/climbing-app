import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/core/widgets/unexpected_behavior.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/core/widgets/styled_password_field.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

class SignInPage extends StatelessWidget {
  final usernameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final void Function() onSuccessSignIn;

  SignInPage({Key? key, required this.onSuccessSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
      onSingleResult: onUserSingleResult,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state.maybeWhen(
              initializationFailure: (failure) => const UnexpectedBehavior(),
              orElse: () => SizedBox.expand(
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
                                  color:
                                      AppTheme.of(context).colorTheme.secondary,
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
                                  isLoaded: state.maybeWhen(
                                    loading: () => false,
                                    orElse: () => true,
                                  ),
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
                                      signInRoute: SignInRoute(
                                        onSuccessSignIn: onSuccessSignIn,
                                      ),
                                    ),
                                  ),
                                  child: const Text("Регистрация"),
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
              ),
            ),
          ),
        );
      },
    );
  }

  void onUserSingleResult(BuildContext context, UserSingleResult singleResult) {
    final customToast = CustomToast(context);
    // ignore: avoid-ignoring-return-values
    singleResult.maybeWhen<void>(
      failure: (failure) =>
          customToast.showTextFailureToast(failureToText(failure)),
      signInFailure: (signInFailure) =>
          customToast.showTextFailureToast(signInFailure.when(
        badCredentials: () => "Неверный логин или пароль",
        userNotVerified: () => "Пользователь не прошёл верификацию",
        validationError: (text) => text,
      )),
      signInSucceed: () {
        onSuccessSignIn();
        // ignore: avoid-ignoring-return-values
        AutoRouter.of(context).pop();
      },
      orElse: () =>
          GetIt.I<Logger>().w('Unexpected user single result: $singleResult'),
    );
  }
}
