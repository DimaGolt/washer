import 'dart:math';

import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washu/app/router.dart';
import 'package:washu/feature/book_laundry/presentation/widgets/styled_dropdown_button.dart';
import 'package:washu/shared/utils/datetime.dart';
import 'package:washu/shared/widgets/laundry_time_picker.dart';

import '../bloc/book_laundry_bloc.dart';

@RoutePage()
class BookLaundryScreen extends StatefulWidget {
  const BookLaundryScreen({super.key});

  @override
  State<BookLaundryScreen> createState() => _BookLaundryScreenState();
}

class _BookLaundryScreenState extends State<BookLaundryScreen> {
  DateTime pickedDate = DateTime.now().toNextHalf();

  final DateFormat dateFormat = DateFormat("EEE, d MMM");

  @override
  Widget build(BuildContext context) {
    BookLaundryState state = context.read<BookLaundryBloc>().state;

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
                  'Machine nr. ${state.selectedLaundromat!.number}',
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Floor ${state.selectedFloor!.level}'),
                      Text(state.selectedDorm!.name),
                    ],
                  ),
                  Text('Max weight: 5 kg'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ListTile(
                tileColor: Colors.white,
                leading: Icon(Icons.calendar_month_outlined),
                iconColor: Colors.black,
                title: InkWell(
                  onTap: () => showLaundryTimePicker(
                    context: context,
                    initialDate: pickedDate,
                  ).then((value) {
                    if (value != null) {
                      pickedDate = value;
                      setState(() {});
                    }
                  }),
                  child: Text(dateFormat.format(pickedDate)),
                ),
                trailing: Text(
                    '${pickedDate.hour.toString().padLeft(2, '0')}:${pickedDate.minute.toString().padLeft(2, '0')}'),
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
