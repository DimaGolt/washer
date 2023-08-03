import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/shared/data/app_auth_repository.dart';
import 'package:washu/shared/utils/string_regexp.dart';
import 'package:washu/shared/widgets/logo_widget.dart';

import '../../../../shared/widgets/background_wave_container.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormFieldState> emailKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey();
  final GlobalKey<FormFieldState> repeatKey = GlobalKey();

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
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            key: emailKey,
            style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            decoration: Theme.of(context).emailDecoration(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'E-mail can\'t be empty';
              }
              return value.matchesEmail() ? null : 'E-mail invalid';
            },
          ),
          TextFormField(
            key: passwordKey,
            style: const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
            textAlign: TextAlign.center,
            decoration: Theme.of(context).passwordDecoration(
              suffixVisible: true,
              onTap: () {
                AppAuthRepository().signOut();
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
            decoration: Theme.of(context).passwordDecoration(suffixVisible: false),
            validator: (value) {
              if (value != passwordKey.currentState!.value) {
                return 'Passwords aren\'t the same';
              }
              return null;
            },
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
