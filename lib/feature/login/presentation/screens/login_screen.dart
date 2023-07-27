import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/shared/widgets/background_wave_container.dart';
import 'package:washu/shared/widgets/logo_widget.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ..._form(context),
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

  _form(BuildContext context) {
    return [
      TextField(
        style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: Theme.of(context).emailDecoration(),
      ),
      TextField(
        style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
        textAlign: TextAlign.center,
        decoration: Theme.of(context).passwordDecoration(true),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              //TODO: Add Google login
            },
            style: Theme.of(context).circularButtonThemeInverted,
            child: FaIcon(
              FontAwesomeIcons.google,
              color: Theme.of(context).primaryColor,
              size: 36,
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonThemeInverted,
              onPressed: () {
                //TODO: Add verification and login
              },
              child: Text(
                'button_login',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ).tr(),
            ),
          ),
        ],
      ),
    ];
  }
}
