import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washer/app/router.dart';
import 'package:washer/feature/settings/presentation/widgets/settings_button.dart';
import 'package:washer/feature/settings/presentation/widgets/settings_dropdown.dart';
import 'package:washer/shared/domain/entities/fire_user_entity.dart';
import 'package:washer/shared/domain/repositories/auth_repository.dart';
import 'package:washer/shared/domain/repositories/db_repository.dart';
import 'package:washer/shared/widgets/appbar_wave.dart';
import 'package:washer/shared/widgets/washer_scroll_view.dart';

import '../../../../shared/domain/entities/dorm_entity.dart';

@RoutePage()
class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({super.key});

  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  bool isLoading = true;
  List<Dorm> dorms = [];
  Dorm? selectedDorm;
  FireUser? user;

  @override
  void initState() {
    _load();
    super.initState();
  }

  _load() async {
    setState(() {
      isLoading = true;
    });
    var dbRepo = context.read<DbRepository>();
    var authRepo = context.read<AuthRepository>();

    dorms = await dbRepo.getDorms();
    user = await dbRepo.getFireUser(authRepo.user!.uid);
    selectedDorm = dorms.firstWhere((element) => element.name == user?.favDorm?.name);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWave(
        title: 'Personal settings',
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WasherScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SettingsButton(icon: Icons.key, text: 'Change password', onPressed: () {}),
                    SettingsDropdown(
                      icon: Icons.apartment,
                      text: 'Choose dorm',
                      onChanged: (_) {},
                      items: dorms,
                      selectedItem: selectedDorm,
                      itemBuilder: (dorm) {
                        return DropdownMenuItem(
                          value: dorm,
                          child: Text(
                            dorm?.name ?? '',
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
