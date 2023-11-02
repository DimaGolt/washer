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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Machine nr. X',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '\$ 0.25/h',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'To book a washing machine fill the form below. \nProvide time and date and choose program type.',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text('Floor ${state.selectedFloor!.level}'),
                      // Text(state.selectedDorm!.name),
                      Text('Floor X'),
                      Text('T-X'),
                    ],
                  ),
                  Text('Max weight: 5 kg'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ListTile(
                tileColor: Colors.white,
                leading: Icon(Icons.calendar_month_outlined),
                iconColor: Colors.black,
                title: Text('Thu, 1 Sep'),
                trailing: Text('10:00'),
              ),
            ),
            StyledDropdownButton(
              selectedValue: null,
              values: [],
              onChanged: (_) {},
              hintText: 'Choose type of wash',
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              leading: const Icon(Icons.list),
            ),
            StyledDropdownButton(
              selectedValue: null,
              values: [],
              onChanged: (_) {},
              hintText: 'Choose temperature',
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              leading: const Icon(Icons.thermostat),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '\$ 1',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Center(child: Text('Book machine')))
          ],
        ),
      ),
    );
  }
}
