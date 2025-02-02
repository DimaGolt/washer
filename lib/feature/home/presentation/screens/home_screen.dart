import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washer/app/router.dart';
import 'package:washer/feature/home/presentation/widgets/active_laundry_button.dart';
import 'package:washer/feature/home/presentation/widgets/menu_tile.dart';
import 'package:washer/shared/domain/repositories/auth_repository.dart';
import 'package:washer/shared/domain/repositories/db_repository.dart';

import '../../../../shared/domain/entities/reservation_entity.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Reservation? activeLaundry;

  @override
  void initState() {
    super.initState();
    _checkActive();
  }

  _checkActive() async {
    activeLaundry = await context
        .read<DbRepository>()
        .checkActiveLaundry(context.read<AuthRepository>().user!.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'greetings'.tr(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.read<AuthRepository>().user?.displayName ?? 'Not logged user',
                      style: const TextStyle(color: Colors.white, fontSize: 34),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                  child: Column(
                    children: [
                      if (activeLaundry != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 54.0, horizontal: 26),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ActiveLaundryButton(
                              onTap: () => context.router
                                  .showActiveLaundry(activeLaundry!)
                                  .then((_) => _checkActive()),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: GridView.count(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 36,
                          crossAxisCount: 2,
                          children: [
                            MenuTile(
                              onTap: () =>
                                  context.router.showPickMachine().then((_) => _checkActive()),
                              icon: FontAwesomeIcons.solidCalendarMinus,
                              label: 'book_laundry'.tr(),
                              position: TilePosition.upLeft,
                            ),
                            MenuTile(
                              onTap: () => context.router.showReport().then((_) => _checkActive()),
                              icon: FontAwesomeIcons.solidFlag,
                              label: 'report_machine'.tr(),
                              position: TilePosition.upRight,
                            ),
                            MenuTile(
                              onTap: () =>
                                  context.router.showReservations().then((_) => _checkActive()),
                              icon: FontAwesomeIcons.solidCalendarDays,
                              label: 'check_bookings'.tr(),
                              position: TilePosition.downLeft,
                            ),
                            MenuTile(
                              onTap: () =>
                                  context.router.showSettings().then((_) => _checkActive()),
                              icon: FontAwesomeIcons.gear,
                              label: 'settings'.tr(),
                              position: TilePosition.downRight,
                              isFaded: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
