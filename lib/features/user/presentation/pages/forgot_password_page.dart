import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const Pad(all: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text('Email', style: AppTheme.of(context).textTheme.subtitle2),
            const SizedBox(height: 8),
            StyledTextField(
              hintText: 'Email',
              controller: emailController,
            ),
            const Spacer(),
            SingleResultBlocBuilder<UserBloc, UserState, UserSingleResult>(
              onSingleResult: (context, singleResult) => singleResult.maybeMap(
                  success: (value) =>
                      GetIt.I<AppRouter>().replace(ResetPasswordRoute()),
                  orElse: () => null),
              builder: (context, state) {
                return SubmitButton(
                    text: 'Сброс пароля',
                    isLoaded: state.maybeMap(
                        loading: (_) => false, orElse: () => true),
                    onPressed: () {
                      var email = emailController.text.trim();
                      if (emailValidator.hasMatch(email)) {
                        BlocProvider.of<UserBloc>(context)
                            .add(UserEvent.forgotPassword(email));
                      } else {
                        CustomToast(context)
                            .showTextFailureToast("Неверный формат!");
                      }
                    });
              },
            )
          ],
        ),
      )),
    );
  }
}
