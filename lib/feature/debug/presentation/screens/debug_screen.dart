import 'package:flutter/material.dart';
import 'package:washu/app/router.dart';
import 'package:washu/shared/widgets/appbar_wave.dart';
import 'package:washu/shared/widgets/washu_scroll_view.dart';

@RoutePage()
class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWave(
        title: 'Debug',
      ),
      body: WashuScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Login'),
              onTap: () => context.router.showLoginScreen(),
            ),
            ListTile(
              title: const Text('Register'),
              onTap: () => context.router.showRegisterScreen(),
            ),
            ListTile(
              title: const Text('Forgor 💀'),
              onTap: () => context.router.showForgotPasswordScreen(),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () => context.router.showHomeScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
