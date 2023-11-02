import 'dart:ffi';

import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:washu/app/router.dart';
import 'package:washu/feature/book_laundry/presentation/widgets/styled_dropdown_button.dart';

import '../bloc/book_laundry_bloc.dart';

@RoutePage()
class BookLaundryScreen extends BlocConsumerWidget<BookLaundryBloc, BookLaundryState> {
  const BookLaundryScreen({super.key});

  @override
  Widget buildWithState(BuildContext context, bloc, state) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Machine nr. X'),
                Text('\$ 0.25/h'),
              ],
            ),
            const Text(
              'To book a washing machine fill the form below. \nProvide time and date and choose program type.',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Floor ${state.selectedFloor!.level}'),
                Text(state.selectedDorm!.name),
              ],
            ),
            const Text('Max weight 5 kg'),
            const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.calendar_month_outlined),
              title: Text('Thu, 1 Sep'),
              trailing: Text('10:00'),
            ),
            StyledDropdownButton(
                selectedValue: null,
                values: [],
                onChanged: (_) {},
                hintText: 'Choose type of wash'),
            StyledDropdownButton(
                selectedValue: null, values: [], onChanged: (_) {}, hintText: 'Choose temperature'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:'),
                Text('\$ 1'),
              ],
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(onPressed: () {}, child: const Center(child: Text('Book machine')))
          ],
        ),
      ),
    );
  }
}
