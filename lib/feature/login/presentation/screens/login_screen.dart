import 'package:auto_route/annotations.dart';
import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/feature/login/presentation/bloc/login_cubit.dart';
import 'package:washu/shared/utils/string_regexp.dart';
import 'package:washu/shared/widgets/background_wave_container.dart';
import 'package:washu/shared/widgets/logo_widget.dart';

@RoutePage()
class LoginScreen extends BlocConsumerWidget<LoginCubit, LoginState> {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormFieldState> emailKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isObscured = ValueNotifier(true);

  @override
  void listener(BuildContext context, LoginCubit bloc, LoginState state) {
    state.maybeMap(
      error: (state) {
        isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
      },
      // success: (state) {},
      loading: (state) => isLoading.value = true,
      orElse: () => isLoading.value = (state is Loading),
    );
  }

  @override
  Widget buildWithState(context, bloc, state) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                const LogoWidget(),
                const Spacer(),
                BackgroundWaveContainer(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ..._form(bloc, theme),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'button_forgot_password',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _form(LoginCubit bloc, ThemeData theme) {
    return [
      TextFormField(
        key: emailKey,
        style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: theme.emailDecoration(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'E-mail can\'t be empty';
          }
          return value.matchesEmail() ? null : 'E-mail invalid';
        },
      ),
      ValueListenableBuilder(
        builder: (_, obscured, __) => TextFormField(
          key: passwordKey,
          style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
          textAlign: TextAlign.center,
          obscureText: obscured,
          decoration: theme.passwordDecoration(
            suffixVisible: true,
            onTap: () => isObscured.value = !obscured,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password can\'t be empty';
            }
            return value.matchesPassword() ? null : 'Password invalid';
          },
        ),
        valueListenable: isObscured,
      ),
      ValueListenableBuilder(
        builder: (_, isLoading, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : bloc.loginGoogle,
              style: theme.circularButtonThemeInverted,
              child: FaIcon(
                FontAwesomeIcons.google,
                color: theme.primaryColor,
                size: 36,
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: theme.elevatedButtonThemeInverted,
                onPressed: isLoading ? null : () => _validateAndLogin(bloc),
                child: Text(
                  'button_login',
                  style: TextStyle(
                    fontSize: 20,
                    color: theme.primaryColor,
                  ),
                ).tr(),
              ),
            ),
          ],
        ),
        valueListenable: isLoading,
      ),
    ];
  }

  _validateAndLogin(LoginCubit bloc) {
    if (formKey.currentState!.validate()) {
      bloc.loginWithEmail(emailKey.currentState!.value, passwordKey.currentState!.value);
    }
  }
}
