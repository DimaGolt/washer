import 'package:auto_route/auto_route.dart';
import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/dorm_entity.dart';
import '../../../../shared/domain/entities/floor_entity.dart';
import '../../../../shared/domain/entities/laundromat_entity.dart';
import '../bloc/book_laundry_bloc.dart';

@RoutePage()
class BookLaundryScreen extends BlocConsumerWidget<BookLaundryBloc, BookLaundryState> {
  BookLaundryScreen({super.key});

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
                      value: state.selectedDorm,
                      items: state.dorms
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: state.status != BookLaundryStatus.initial
                          ? (val) {
                              if (val != null) {
                                bloc.add(BookLaundryPickDorm(val));
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
                      value: state.selectedFloor,
                      items: state.floors
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text('${e.level} floor'),
                              ))
                          .toList(),
                      onChanged: state.selectedDorm != null
                          ? (val) {
                              if (val != null) {
                                bloc.add(BookLaundryPickFloor(val));
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
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: state.laundromats
                        .map((e) => Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_laundry_service_outlined),
                                  Center(child: Text('${e.floor!.level}')),
                                ],
                              ),
                            ))
                        .toList(),
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
