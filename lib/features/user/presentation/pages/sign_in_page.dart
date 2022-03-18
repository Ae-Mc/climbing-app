import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_bloc_builder.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_event.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_single_result.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_state.dart';
import 'package:climbing_app/features/user/presentation/widgets/styled_password_field.dart';
import 'package:climbing_app/features/user/presentation/widgets/styled_text_field.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInPage extends StatelessWidget {
  final usernameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final void Function() onSuccessLogin;

  SignInPage({Key? key, required this.onSuccessLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<UserBloc>(),
      child: Builder(builder: (context) {
        return SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
          onSingleResult: onUserSingleResult,
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: SizedBox.expand(
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
                                    color: AppTheme.of(context)
                                        .colorTheme
                                        .secondary,
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
                                  ElevatedButton(
                                    onPressed: () =>
                                        BlocProvider.of<UserBloc>(context).add(
                                      UserEvent.login(
                                        usernameOrEmailController.text,
                                        passwordController.text,
                                      ),
                                    ),
                                    child: const Text('Войти'),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton(
                                    onPressed: () => {},
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
                        child: CustomBackButton(size: 48),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void onUserSingleResult(BuildContext context, UserSingleResult singleResult) {
    final customToast = GetIt.I<CustomToast>(param1: context);
    // ignore: avoid-ignoring-return-values
    singleResult.when<void>(
      badCredentialsFailure: () =>
          customToast.showTextFailureToast("Неверный логин или пароль"),
      connectionFailure: () =>
          customToast.showTextFailureToast("Ошибка соединения"),
      loginSucceed: () => AutoRouter.of(context).pop(),
      userNotVerifiedFailure: () => customToast
          .showTextFailureToast("Пользователь не прошёл верификацию"),
      unknownFailure: () => customToast.showTextFailureToast(
        'Произошла неизвестная ошибка. Свяжитесь с разработчиком',
      ),
      validationFailure: (text) =>
          customToast.showTextFailureToast('Ошибка валидации: $text'),
    );
  }
}
