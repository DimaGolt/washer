import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washu/app/router.dart';
import 'package:washu/feature/home/presentation/widgets/active_laundry_button.dart';
import 'package:washu/feature/home/presentation/widgets/menu_tile.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 54.0, horizontal: 26),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ActiveLaundryButton(
                            onTap: () {},
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
                              onTap: () {},
                              icon: FontAwesomeIcons.solidCalendarMinus,
                              label: 'book_laundry'.tr(),
                              position: TilePosition.upLeft,
                            ),
                            MenuTile(
                              onTap: () {},
                              icon: FontAwesomeIcons.solidFlag,
                              label: 'report_machine'.tr(),
                              position: TilePosition.upRight,
                            ),
                            MenuTile(
                              onTap: () {},
                              icon: FontAwesomeIcons.solidCalendarDays,
                              label: 'check_bookings'.tr(),
                              position: TilePosition.downLeft,
                            ),
                            MenuTile(
                              onTap: () {},
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
