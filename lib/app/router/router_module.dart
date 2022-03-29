import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/router/guards/auth_guard.dart';
import 'package:climbing_app/features/user/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterModule {
  @singleton
  AppRouter appRouter(AuthGuard authGuard) => AppRouter(authGuard: authGuard);

  @singleton
  AuthGuard authGuard(UserRepository userRepository) =>
      AuthGuard(() => userRepository.isAuthenticated);
}
