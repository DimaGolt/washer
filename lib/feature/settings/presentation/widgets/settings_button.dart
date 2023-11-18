import 'package:flutter/material.dart';
import 'package:washer/app/theme.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ElevatedButton(
          onPressed: onPressed,
          style: theme.elevatedButtonThemeInverted
              .copyWith(elevation: const MaterialStatePropertyAll(5)),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: theme.primaryColor,
                  size: 42,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                  text,
                  style: TextStyle(color: theme.primaryColor, fontSize: 20),
                  softWrap: true,
                  maxLines: 2,
                )),
                const SizedBox(width: 20),
                Material(
                  elevation: 4,
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(Icons.arrow_forward_ios, color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
