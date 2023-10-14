import 'package:flutter/material.dart';

class WasherScrollView extends StatelessWidget {
  final Widget child;

  const WasherScrollView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
            top: kToolbarHeight + 75, bottom: MediaQuery.of(context).viewInsets.bottom + 125),
        child: child,
      ),
    );
  }
}
