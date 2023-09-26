import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LiquidIndicator extends StatelessWidget {
  const LiquidIndicator({super.key, required this.percentage});
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.lightBlue),
          child: RotatedBox(
            quarterTurns: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: WaveWidget(
                config: CustomConfig(
                  colors: [
                    const Color(0xFF1D85FF),
                  ],
                  durations: [4000],
                  heightPercentages: [1 - (1.02 * percentage / 100 + 0.1)],
                ),
                size: const Size(double.infinity, double.infinity),
                waveAmplitude: 0,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
