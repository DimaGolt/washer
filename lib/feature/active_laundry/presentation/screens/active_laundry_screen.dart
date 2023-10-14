import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:washer/app/router.dart';
import 'package:flutter/material.dart';
import 'package:washer/feature/active_laundry/presentation/widgets/laundry_window_widget.dart';

import '../widgets/liquid_progress_indicator.dart';

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
                'active_laundry_title',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ).tr(),
              const Text(
                'active_laundry_text',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4D4D4)),
              ).tr(),
              const Center(
                child: LaundryWindowWidget(),
              ),
              const SizedBox(
                height: 60,
                width: double.infinity,
                child: LiquidIndicator(
                  percentage: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
