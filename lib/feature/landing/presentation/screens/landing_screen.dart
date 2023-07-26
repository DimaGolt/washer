import 'package:flutter/material.dart';
import 'package:washu/shared/widgets/background_wave_container.dart';
import 'package:washu/shared/widgets/logo_widget.dart';

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
                onPressed: () {},
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              const SizedBox(height: 34),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
