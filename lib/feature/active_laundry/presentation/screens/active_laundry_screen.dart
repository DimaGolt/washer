import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:washer/app/router.dart';
import 'package:flutter/material.dart';
import 'package:washer/feature/active_laundry/presentation/widgets/laundry_window_widget.dart';

import '../../../../shared/domain/entities/reservation_entity.dart';
import '../widgets/liquid_progress_indicator.dart';

@RoutePage()
class ActiveLaundryScreen extends StatefulWidget {
  const ActiveLaundryScreen({super.key, required this.reservation});

  final Reservation reservation;

  @override
  State<ActiveLaundryScreen> createState() => _ActiveLaundryScreenState();
}

class _ActiveLaundryScreenState extends State<ActiveLaundryScreen> {
  late Timer timer;
  int percentage = 0;

  @override
  void initState() {
    _updatePercentage();
    timer = Timer.periodic(const Duration(seconds: 30), (_) => _updatePercentage());
    super.initState();
  }

  _updatePercentage() {
    if (percentage != 100) {
      var wholeDuration = widget.reservation.end!.difference(widget.reservation.start!);
      var durationToNow = DateTime.now().difference(widget.reservation.start!);
      percentage = ((durationToNow.inMinutes * 100) / wholeDuration.inMinutes).ceil();
      setState(() {});
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
              SizedBox(
                height: 60,
                width: double.infinity,
                child: LiquidIndicator(
                  percentage: percentage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
