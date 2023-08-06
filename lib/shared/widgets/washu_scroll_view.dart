import 'package:flutter/material.dart';

class WashuScrollView extends StatelessWidget {
  final List<Widget> children;

  const WashuScrollView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight + 75),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
