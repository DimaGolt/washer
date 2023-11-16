import 'package:auto_route/auto_route.dart';
export 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:washer/feature/book_laundry/presentation/screens/pick_machine_screen.dart';

import '../feature/active_laundry/presentation/screens/active_laundry_screen.dart';
import '../feature/book_laundry/presentation/screens/book_laundry_screen.dart';
import '../feature/debug/presentation/screens/debug_screen.dart';
import '../feature/forgor_pass/presentation/screens/forgot_password_screen.dart';
import '../feature/home/presentation/screens/home_screen.dart';
import '../feature/landing/presentation/screens/landing_screen.dart';
import '../feature/login/presentation/screens/login_screen.dart';
import '../feature/register/presentation/screens/register_screen.dart';
import '../feature/reservations/presentation/screens/reservations_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: DebugRoute.page),
        AutoRoute(page: ActiveLaundryRoute.page),
        AutoRoute(page: PickMachineRoute.page),
        AutoRoute(page: BookLaundryRoute.page),
        AutoRoute(page: ReservationsRoute.page),
      ];
}

extension RouterExtension on StackRouter {
  Future showLoginScreen() => push(LoginRoute());

  Future showRegisterScreen() => push(RegisterRoute());

  Future showForgotPasswordScreen() => push(ForgotPasswordRoute());

  Future showHomeScreen() => pushAndPopUntil(const HomeRoute(), predicate: (_) => false);

  Future showHomeScreenDebug() => push(const HomeRoute());

  Future showDebugScreen() => push(const DebugRoute());

  Future showActiveLaundry() => push(const ActiveLaundryRoute());

  Future showPickMachine() => push(const PickMachineRoute());

  Future showBookLaundry() => push(const BookLaundryRoute());

  Future showReservations() => push(const ReservationsRoute());
}
