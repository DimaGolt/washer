import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/shared/widgets/appbar_wave.dart';
import 'package:washu/shared/widgets/washu_scroll_view.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              TextField(
                style: TextStyle(color: theme.primaryColor, fontSize: 20),
                textAlign: TextAlign.center,
                decoration: theme.emailForgotDecoration(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity, maxHeight: 58),
          child: ElevatedButton(
            child: Center(
              child: const Text(
                'forgot_password_fab',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ).tr(),
            ),
            onPressed: () {}, //TODO: implement reset
          ),
        ),
      ),
    );
  }
}
