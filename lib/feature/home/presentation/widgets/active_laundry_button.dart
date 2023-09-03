import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActiveLaundryButton extends StatelessWidget {
  const ActiveLaundryButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 4,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF5089F9),
              Color(0xFF575F89),
            ],
            transform: GradientRotation(0.5 * pi),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                FontAwesomeIcons.solidClock,
                size: 46,
                color: Colors.white,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'active_laundry_title'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'active_laundry_subtitle'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
