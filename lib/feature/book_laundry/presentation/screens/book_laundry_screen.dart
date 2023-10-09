import 'package:auto_route/auto_route.dart';
import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:washu/feature/book_laundry/presentation/bloc/book_laundry_bloc.dart';

import '../../../../shared/domain/entities/dorm_entity.dart';
import '../../../../shared/domain/entities/floor_entity.dart';
import '../../../../shared/domain/entities/laundromat_entity.dart';

@RoutePage()
class BookLaundryScreen extends BlocConsumerWidget<BookLaundryBloc, BookLaundryState> {
  BookLaundryScreen({super.key});

  List<Dorm> dorms = [];
  List<Floor> floors = [];
  List<Laundromat> laundromats = [];

  Dorm? selectedDorm;
  Floor? selectedFloor;

  bool enableDorms = false;
  bool enableFloors = false;

  @override
  void listener(BuildContext context, BookLaundryBloc bloc, BookLaundryState state) {
    state.maybeMap(
      loadedDorms: (state) {
        dorms = state.dorms;
        enableDorms = true;
        enableFloors = false;
      },
      pickedDorm: (state) {
        floors = state.floors;
        enableFloors = true;
      },
      pickedFloor: (state) {
        laundromats = state.laundromats;
      },
      orElse: () {},
    );
  }

  @override
  void onMount(BookLaundryBloc bloc) {
    super.onMount(bloc);
    bloc.add(BookLaundryEvent.started());
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
                    DropdownButton2<Dorm>(
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white)))),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.expand_more),
                        iconSize: 32,
                        iconEnabledColor: Colors.white,
                      ),
                      hint: const Text(
                        'Pick your dorm',
                        style: TextStyle(color: Colors.white),
                      ),
                      disabledHint: Text(
                        'Please wait...',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      value: selectedDorm,
                      items: dorms
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: enableDorms
                          ? (val) {
                              selectedDorm = val;
                              if (selectedDorm != null) {
                                bloc.add(BookLaundryEvent.pickDorm(selectedDorm!));
                              }
                            }
                          : null,
                    ),
                    DropdownButton2<Floor>(
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white)))),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.expand_more),
                        iconSize: 32,
                        iconEnabledColor: Colors.white,
                      ),
                      hint: const Text(
                        'Pick your floor',
                        style: TextStyle(color: Colors.white),
                      ),
                      disabledHint: Text(
                        'Please, pick your dorm first',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      value: selectedFloor,
                      items: floors
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text('${e.level} floor'),
                              ))
                          .toList(),
                      onChanged: enableFloors
                          ? (val) {
                              selectedFloor = val;
                              if (selectedFloor != null) {
                                bloc.add(BookLaundryEvent.pickFloor(selectedFloor!));
                              }
                            }
                          : null,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
