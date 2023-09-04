import 'dart:math';

import 'package:washu/app/router.dart';
import 'package:flutter/material.dart';
import 'package:washu/feature/active_laundry/presentation/widgets/laundry_window_widget.dart';

@RoutePage()
class ActiveLaundryScreen extends StatelessWidget {
  const ActiveLaundryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: context.router.pop,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF68A8C9),
            Color(0xFF445D6A),
          ],
          transform: GradientRotation(0.35 * pi),
        )),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
              left: 50,
              right: 50,
              bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Laundry in progress',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text(
                'While the laundry works its magic, why not treat yourself to a small indulgence? Savor a cup of your favorite tea or coffee, or nibble on a delightful snack. Let this be your personal time to recharge and embrace moments of self-discovery.',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4D4D4)),
              ),
              const Center(
                child: LaundryWindowWidget(),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text('data'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
