import 'package:flutter/material.dart';
import 'package:washer/app/router.dart';
import 'package:washer/shared/widgets/appbar_wave.dart';
import 'package:washer/shared/widgets/washer_scroll_view.dart';

@RoutePage()
class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWave(
        title: 'My reservations', //TODO: translate
      ),
      body: WasherScrollView(
        child: Column(
          children: List.generate(
            20,
            (index) => Card(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Place: T-15 1st floor'),
                        Text('Machine nr. : 4'),
                        Text('Time: Wed 14:30'),
                      ],
                    ),
                    Text('\$ 0.25'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
