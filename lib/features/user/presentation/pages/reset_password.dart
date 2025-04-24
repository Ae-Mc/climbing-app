import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/widgets/styled_password_field.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/user/domain/entities/password_reset_failure.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  final String? token;

  const ResetPasswordPage({super.key, @PathParam('token') this.token});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  @override
  void initState() {
    tokenController.text = widget.token ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const Pad(all: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text('Токен', style: textTheme.subtitle2),
            const SizedBox(height: 8),
            StyledTextField(
              hintText: 'Токен',
              controller: tokenController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            Text('Новый пароль', style: textTheme.subtitle2),
            const SizedBox(height: 8),
            StyledPasswordField(
              hintText: 'Новый пароль',
              controller: passwordController,
            ),
            const SizedBox(height: 8),
            Text('Повтор пароля', style: textTheme.subtitle2),
            const SizedBox(height: 8),
            StyledPasswordField(
              hintText: 'Повтор пароля',
              controller: passwordRepeatController,
            ),
            const Spacer(),
            SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
              onSingleResult: (context, singleResult) => switch (singleResult) {
                UserSingleResultSuccess() => GetIt.I<AppRouter>().maybePop(),
                UserSingleResultPasswordResetFailure(:final failure) =>
                  CustomToast(context).showTextFailureToast(
                    switch (failure) {
                      PasswordResetFailureBadPassword() =>
                        "Неверный формат пароля (слишком короткий?)",
                      PasswordResetFailureValidationError(:final text) => text,
                      PasswordResetFailureWrongToken() => "Неверный токен",
                    },
                  ),
                _ => null,
              },
              builder: (context, state) => SubmitButton(
                  text: 'Сброс пароля',
                  isLoaded: state is! UserStateLoading,
                  onPressed: () {
                    if (passwordController.text ==
                        passwordRepeatController.text) {
                      BlocProvider.of<UserBloc>(context).add(
                        UserEvent.resetPassword(
                          tokenController.text,
                          passwordController.text,
                        ),
                      );
                    } else {
                      CustomToast(context)
                          .showTextFailureToast("Пароли не совпадают");
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}
