import 'package:flutter/cupertino.dart';

class ConditionalBuilder extends StatelessWidget {
  const ConditionalBuilder({
    super.key,
    required this.condition,
    required this.child,
    required this.builder,
  });

  final bool condition;
  final Widget child;
  final Widget Function(BuildContext context, Widget child) builder;

  @override
  Widget build(BuildContext context) {
    return condition ? builder(context, child) : child;
  }
}
