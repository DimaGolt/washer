import 'package:auto_route/auto_route.dart';
import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:washu/app/router.dart';
import 'package:washu/feature/book_laundry/presentation/widgets/styled_dropdown_button.dart';

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
        title: const Text('Book Laundry'),
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
                      hintText: 'Dorm',
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
                      hintText: 'Floor',
                      selectedValue: state.selectedFloor,
                      values: state.floors
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text('Floor ${e.level}'),
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
                                Text('Machine nr. ${e.number}'),
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
                                        Text('Floor ${e.floor!.level}'),
                                      ],
                                    ),
                                    const Column(
                                      children: [
                                        Text('Price:'),
                                        Text(
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
