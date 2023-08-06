import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:washu/shared/widgets/appbar_wave.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWave(
        title: 'Forgot pass',
      ),
      body: Center(
        child: Container(
          child: Text('text'),
        ),
      ),
    );
  }
}
