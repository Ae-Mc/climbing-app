import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/features/user/presentation/widgets/styled_password_field.dart';
import 'package:climbing_app/features/user/presentation/widgets/styled_text_field.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  final usernameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
  }
}
