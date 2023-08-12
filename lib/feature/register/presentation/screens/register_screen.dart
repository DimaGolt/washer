import 'package:washu/app/router.dart';
import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/feature/register/presentation/bloc/register_cubit.dart';
import 'package:washu/shared/utils/string_regexp.dart';
import 'package:washu/shared/widgets/logo_widget.dart';

import '../../../../shared/widgets/background_wave_container.dart';

@RoutePage()
class RegisterScreen extends BlocConsumerWidget<RegisterCubit, RegisterState> {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormFieldState> emailKey = GlobalKey();
  final GlobalKey<FormFieldState> nameKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey();
  final GlobalKey<FormFieldState> repeatKey = GlobalKey();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isObscured = ValueNotifier(true);

  @override
  void listener(BuildContext context, RegisterCubit bloc, RegisterState state) {
    state.maybeMap(
      error: (state) {
        isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
      },
      loading: (state) => isLoading.value = true,
      orElse: () => isLoading.value = (state is Loading),
    );
  }

  @override
  Widget buildWithState(context, bloc, state) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
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
                  height: 450,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 20.0),
                    child: _form(bloc, theme),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _form(RegisterCubit bloc, ThemeData theme) {
    return Form(
      key: formKey,
      child: ValueListenableBuilder(
          valueListenable: isObscured,
          builder: (_, obscured, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                TextFormField(
                  key: nameKey,
                  style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  decoration: theme.nameDecoration(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name can\'t be empty';
                    }
                    return value.contains(' ') ? null : 'Name invalid';
                  },
                ),
                TextFormField(
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
                TextFormField(
                  key: repeatKey,
                  style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
                  textAlign: TextAlign.center,
                  obscureText: obscured,
                  decoration: theme.passwordDecoration(suffixVisible: false),
                  validator: (value) {
                    if (value != passwordKey.currentState!.value) {
                      return 'Passwords aren\'t the same';
                    }
                    return null;
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (_, isLoading, __) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: isLoading ? null : bloc.registerGoogle,
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
                              onPressed: isLoading ? null : () => _validateAndRegister(bloc),
                              child: Text(
                                'button_register',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: theme.primaryColor,
                                ),
                              ).tr(),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            );
          }),
    );
  }

  _validateAndRegister(RegisterCubit bloc) {
    if (formKey.currentState!.validate()) {
      bloc.registerWithEmail(
        emailKey.currentState!.value,
        passwordKey.currentState!.value,
        nameKey.currentState!.value,
      );
    }
  }
}
