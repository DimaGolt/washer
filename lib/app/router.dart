import 'package:auto_route/auto_route.dart';

import '../feature/landing/presentation/screens/landing_screen.dart';
import '../feature/login/presentation/screens/login_screen.dart';
import '../feature/register/presentation/screens/register_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
      ];
}

extension RouterExtension on StackRouter {
  Future showLoginScreen() => push(const LoginRoute());

  Future showRegisterScreen() => push(const RegisterRoute());
}
