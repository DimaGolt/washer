import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:washu/app/router.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/shared/widgets/background_wave_container.dart';
import 'package:washu/shared/widgets/logo_widget.dart';

@RoutePage()
class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: LogoWidget()),
      bottomNavigationBar: BackgroundWaveContainer(
        height: 270,
        multiplier: 2.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: context.router.showLoginScreen,
                style: Theme.of(context).elevatedButtonThemeInverted,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'button_login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ).tr(),
                  ),
                ),
              ),
              const SizedBox(height: 34),
              TextButton(
                onPressed: context.router.showRegisterScreen,
                child: const Text(
                  'button_no_account',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
