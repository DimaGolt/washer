import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:washer/app/router.dart';
import 'package:washer/feature/book_laundry/presentation/widgets/styled_dropdown_button.dart';

import '../bloc/book_laundry_bloc.dart';

@RoutePage()
class PickMachineScreen extends BlocConsumerWidget<BookLaundryBloc, BookLaundryState> {
  const PickMachineScreen({super.key});

  @override
  void onMount(BookLaundryBloc bloc) {
    super.onMount(bloc);
    bloc.add(BookLaundryStart());
  }

  @override
  Widget buildWithState(context, bloc, state) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('book_laundry').tr(),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    StyledDropdownButton(
                      selectedValue: state.selectedDorm,
                      hintText: 'dorm'.tr(),
                      values: state.dorms
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: state.status != BookLaundryStatus.initial
                          ? (val) {
                              if (val != null && val != state.selectedDorm) {
                                bloc.add(BookLaundryPickDorm(val));
                              }
                            }
                          : null,
                    ),
                    StyledDropdownButton(
                      margin: const EdgeInsets.only(top: 8, bottom: 16),
                      hintText: 'floor'.tr(args: ['']),
                      selectedValue: state.selectedFloor,
                      values: state.floors
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: const Text('floor').tr(args: [e.level.toString()]),
                              ))
                          .toList(),
                      onChanged: state.selectedDorm != null
                          ? (val) {
                              if (val != null && val != state.selectedFloor) {
                                bloc.add(BookLaundryPickFloor(val));
                              }
                            }
                          : null,
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
                  child: GridView.count(
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    crossAxisCount: 3,
                    children: state.laundromats.map(
                      (e) {
                        final borderRadius = BorderRadius.circular(8);

                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: borderRadius),
                          elevation: 3,
                          child: InkWell(
                            borderRadius: borderRadius,
                            onTap: () {
                              bloc.add(BookLaundryPickMachine(e));
                              bloc.stream
                                  .firstWhere(
                                      (state) => state.status == BookLaundryStatus.pickedMachine)
                                  .then((value) => context.router.showBookLaundry());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('machine_nr').tr(args: [e.number.toString()]),
                                const Icon(
                                  Icons.local_laundry_service_outlined,
                                  size: 54,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.dorm!.name),
                                        const Text('floor').tr(args: [e.floor!.level.toString()]),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('price').tr(),
                                        const Text(
                                          '\$ 0.25/h',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
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
