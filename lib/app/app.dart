import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washu/app/router.dart';
import 'package:washu/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:washu/feature/forgor_pass/presentation/bloc/forgot_password_cubit.dart';
import 'package:washu/feature/login/presentation/bloc/login_cubit.dart';
import 'package:washu/feature/register/presentation/bloc/register_cubit.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';
import 'package:washu/shared/domain/repositories/db_repository.dart';

import '../feature/book_laundry/presentation/bloc/book_laundry_bloc.dart';

class WashuApp extends StatelessWidget {
  WashuApp({Key? key}) : super(key: key);

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
      ],
      child: MaterialApp.router(
        title: 'Washu',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: washuLightTheme,
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
