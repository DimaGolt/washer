import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/shared/data/app_auth_repository.dart';
import 'package:washu/shared/widgets/logo_widget.dart';

import '../../../../shared/widgets/background_wave_container.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 20.0),
                    child: _form(context),
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
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          TextField(
            style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            decoration: Theme.of(context).emailDecoration(),
          ),
          TextField(
            style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
            textAlign: TextAlign.center,
            decoration: Theme.of(context).passwordDecoration(
              suffixVisible: true,
              onTap: () {
                AppAuthRepository().signOut();
              }
            ),
          ),
          TextField(
            style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
            textAlign: TextAlign.center,
            decoration: Theme.of(context).passwordDecoration(suffixVisible: false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  //TODO: Add Google signup
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
                    //TODO: Add verification and signup
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
        ],
      ),
    );
  }
}
