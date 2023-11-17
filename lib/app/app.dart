import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washer/app/router.dart';
import 'package:washer/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:washer/feature/forgor_pass/presentation/bloc/forgot_password_cubit.dart';
import 'package:washer/feature/login/presentation/bloc/login_cubit.dart';
import 'package:washer/feature/register/presentation/bloc/register_cubit.dart';
import 'package:washer/feature/report/presentation/bloc/report_bloc.dart';
import 'package:washer/shared/domain/repositories/auth_repository.dart';
import 'package:washer/shared/domain/repositories/db_repository.dart';
import '../feature/book_laundry/presentation/bloc/book_laundry_bloc.dart';

class WasherApp extends StatelessWidget {
  WasherApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository.build();
    final dbRepository = DbRepository.build();

    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (_) => authRepository),
        RepositoryProvider(create: (_) => dbRepository),
        BlocProvider(create: (_) => LoginCubit(authRepository: authRepository)),
        BlocProvider(create: (_) => RegisterCubit(authRepository: authRepository)),
        BlocProvider(create: (_) => ForgotPasswordCubit(authRepository: authRepository)),
        BlocProvider(create: (_) => BookLaundryBloc(dbRepository: dbRepository)),
        BlocProvider(create: (_) => ReportBloc(dbRepository: dbRepository)),
      ],
      child: MaterialApp.router(
        title: 'Washer',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: washerLightTheme,
        routerConfig: _appRouter.config(),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: 1.0), //TODO: change with clamp someday
          child: child!,
        ),
      ),
    );
  }
}
