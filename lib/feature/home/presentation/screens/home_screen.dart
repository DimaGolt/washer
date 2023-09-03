import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:washu/app/router.dart';
import 'package:washu/feature/home/presentation/widgets/menu_tile.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 26.0),
          mainAxisSpacing: 40,
          crossAxisSpacing: 36,
          crossAxisCount: 2,
          children: [
            MenuTile(
              onTap: () {},
              icon: FontAwesomeIcons.solidCalendarMinus,
              label: 'Book laundry',
              position: TilePosition.upLeft,
            ),
            MenuTile(
              onTap: () {},
              icon: FontAwesomeIcons.solidFlag,
              label: 'Report machine',
              position: TilePosition.upRight,
            ),
            MenuTile(
              onTap: () {},
              icon: FontAwesomeIcons.solidCalendarDays,
              label: 'Check your bookings',
              position: TilePosition.downLeft,
            ),
            MenuTile(
              onTap: () {},
              icon: FontAwesomeIcons.gear,
              label: 'Settings',
              position: TilePosition.downRight,
              isFaded: true,
            ),
          ],
        ),
      ),
    );
  }
}
