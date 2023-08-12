import 'package:flutter/material.dart';

class WashuScrollView extends StatelessWidget {
  final Widget child;

  const WashuScrollView({super.key, required this.child});

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
