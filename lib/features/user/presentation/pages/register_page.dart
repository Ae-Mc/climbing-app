import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/core/widgets/styled_password_field.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final void Function() onSuccessRegister;
  final SignInRoute? signInRoute;

  RegisterPage({Key? key, required this.onSuccessRegister, this.signInRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

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
                              Assets.icons.logo
                                  .svg(color: colorTheme.secondary),
                              const SizedBox(height: 16),
                              Text(
                                '??????????????????????',
                                style: textTheme.title,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              StyledTextField(
                                controller: emailController,
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              StyledTextField(
                                controller: usernameController,
                                hintText: '?????? ????????????????????????',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              StyledTextField(
                                controller: firstNameController,
                                hintText: '??????',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              StyledTextField(
                                controller: lastNameController,
                                hintText: '??????????????',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              StyledPasswordField(
                                controller: passwordController,
                                hintText: '????????????',
                              ),
                              const SizedBox(height: 16),
                              SubmitButton(
                                isLoaded: state.maybeWhen(
                                  orElse: () => true,
                                  loading: () => false,
                                ),
                                onPressed: () =>
                                    BlocProvider.of<UserBloc>(context).add(
                                  UserEvent.register(
                                    UserCreate(
                                      email: emailController.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      password: passwordController.text,
                                      username: usernameController.text,
                                    ),
                                  ),
                                ),
                                text: '????????????????????????????????????',
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => AutoRouter.of(context).replace(
                                  signInRoute ??
                                      SignInRoute(onSuccessSignIn: () => {}),
                                ),
                                child: const Text("????????"),
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
      registerSucceed: () {
        onSuccessRegister();
        // ignore: avoid-ignoring-return-values
        AutoRouter.of(context).pop();
      },
      registerFailure: (registerFailure) =>
          customToast.showTextFailureToast(registerFailure.when(
        validationError: (text) => text,
        userAlreadyExists: () =>
            "???????????????????????? ?? ?????????? ???????????? ???????????????????????? ?????? email'???? ?????? ????????????????????",
        invalidPassword: (reason) => reason,
      )),
      orElse: () =>
          GetIt.I<Logger>().w('Unexpected user single result: $singleResult'),
    );
  }
}
