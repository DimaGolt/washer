import 'package:flutter/material.dart';
import 'package:washu/feature/base/presentation/screens/increment_screen.dart';

class WashuApp extends StatelessWidget {
  const WashuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IncrementScreen(title: 'Increment Page'),
    );
  }
}