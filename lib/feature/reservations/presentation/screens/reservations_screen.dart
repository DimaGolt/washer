import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washer/app/router.dart';
import 'package:washer/shared/domain/repositories/auth_repository.dart';
import 'package:washer/shared/domain/repositories/db_repository.dart';
import 'package:washer/shared/widgets/appbar_wave.dart';
import 'package:washer/shared/widgets/washer_scroll_view.dart';

import '../../../../shared/domain/entities/reservation_entity.dart';

@RoutePage()
class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  bool _isLoading = true;
  List<Reservation> _reservations = [];

  final DateFormat dateFormat = DateFormat("EEE hh:mm");

  @override
  void initState() {
    _getReservations();
    super.initState();
  }

  _getReservations() async {
    setState(() {
      _isLoading = true;
    });
    _reservations = await context
        .read<DbRepository>()
        .getUserReservations(context.read<AuthRepository>().user!.uid);
    setState(() {
      _isLoading = false;
    });
  }

  _deleteReservations(Reservation reservation) async {
    await context
        .read<DbRepository>()
        .deleteReservation(reservation, context.read<AuthRepository>().user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWave(
        title: 'my_reservations',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : WasherScrollView(
              child: Column(
                children: List.generate(
                  _reservations.length,
                  (ind) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: Dismissible(
                      key: GlobalKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (_) {
                        _deleteReservations(_reservations.removeAt(ind));
                        setState(() {});
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                            ),
                            BoxShadow(
                                color: Colors.red,
                                spreadRadius: -0.10,
                                blurRadius: 8.0,
                                blurStyle: BlurStyle.inner),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: 100,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.block,
                                  size: 42,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'cancel_booking',
                                  style: TextStyle(color: Colors.white),
                                ).tr()
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('full_place').tr(args: [
                                    _reservations[ind].dorm!.name,
                                    _reservations[ind].floor!.level.toString()
                                  ]),
                                  const Text('machine_nr')
                                      .tr(args: [_reservations[ind].laundromat!.number.toString()]),
                                  const Text('time')
                                      .tr(args: [dateFormat.format(_reservations[ind].start!)]),
                                ],
                              ),
                              Text('\$ ${_reservations[ind].price!}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
