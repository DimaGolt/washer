import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washu/app/router.dart';
import 'package:washu/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:washu/feature/login/presentation/bloc/login_cubit.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';

class WashuApp extends StatelessWidget {
  WashuApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository.build();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit(authRepository: authRepository)),
      ],
      child: MaterialApp.router(
        title: 'Washu',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: washuLightTheme,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}