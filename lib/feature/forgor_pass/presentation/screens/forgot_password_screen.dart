import 'package:auto_route/annotations.dart';
import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/feature/forgor_pass/presentation/bloc/forgot_password_cubit.dart';
import 'package:washu/shared/utils/string_regexp.dart';
import 'package:washu/shared/widgets/appbar_wave.dart';
import 'package:washu/shared/widgets/washu_scroll_view.dart';

@RoutePage()
class ForgotPasswordScreen extends BlocConsumerWidget<ForgotPasswordCubit, ForgotPasswordState> {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormFieldState> _emailKey = GlobalKey();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  String _email = '';

  @override
  void listener(BuildContext context, ForgotPasswordCubit bloc, ForgotPasswordState state) {
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
      appBar: const AppBarWave(
        title: 'forgot_password_appbar',
      ),
      body: WashuScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'forgot_password_header',
                  style: TextStyle(
                    fontSize: 24,
                    color: theme.primaryColor,
                  ),
                ).tr(),
              ),
              const SizedBox(height: 37),
              Text(
                'forgot_password_text',
                style: TextStyle(
                  fontSize: 22,
                  color: theme.primaryColor,
                ),
              ).tr(),
              const SizedBox(height: 60),
              TextFormField(
                key: _emailKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: theme.primaryColor, fontSize: 20),
                textAlign: TextAlign.center,
                decoration: theme.emailForgotDecoration(),
                onChanged: (val) => _email = val,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-mail can\'t be empty';
                  }
                  return value.matchesEmail() ? null : 'E-mail invalid';
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _fab(bloc),
    );
  }

  _fab(ForgotPasswordCubit bloc) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity, maxHeight: 58),
          child: ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (_, loading, __) => ElevatedButton(
              onPressed: loading
                  ? null
                  : () {
                      if (_emailKey.currentState!.isValid) {
                        bloc.requestCode(_email);
                      }
                    },
              child: Center(
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'forgot_password_fab',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ).tr(),
              ),
            ),
          ),
        ),
      );
}
