import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LaundryWindowWidget extends StatelessWidget {
  const LaundryWindowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shape: const CircleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDFDFD),
              Color(0xFF848687),
            ],
            transform: GradientRotation(0.35 * pi),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 255,
            height: 255,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF6BA5DA),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipOval(
                child: WaveWidget(
                  config: CustomConfig(
                    colors: [
                      Color(0x6B1D85FF),
                      // Colors.red
                      Color(0x6B1D86FF),
                    ],
                    durations: [18000, 9000],
                    heightPercentages: [0.2, 0.2],
                  ),
                  size: Size(double.infinity, double.infinity),
                  waveAmplitude: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
