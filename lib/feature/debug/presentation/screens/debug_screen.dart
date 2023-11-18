import 'package:flutter/material.dart';
import 'package:washer/app/router.dart';
import 'package:washer/shared/widgets/appbar_wave.dart';
import 'package:washer/shared/widgets/washer_scroll_view.dart';

import '../../../../shared/domain/entities/reservation_entity.dart';

@RoutePage()
class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWave(
        title: 'Debug',
      ),
      body: WasherScrollView(
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
              onTap: () => context.router.showHomeScreenDebug(),
            ),
            ListTile(
              title: const Text('Active laundry'),
              onTap: () => context.router.showActiveLaundry(Reservation(
                  start: DateTime.now().add(const Duration(minutes: 12)),
                  end: DateTime.now().add(const Duration(minutes: 30)))),
            ),
          ],
        ),
      ),
    );
  }
}
