import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washer/shared/utils/datetime.dart';

import '../../../../app/router.dart';
import '../../../../shared/widgets/laundry_time_picker.dart';
import '../bloc/book_laundry_bloc.dart';
import '../widgets/styled_dropdown_button.dart';

@RoutePage()
class BookLaundryScreen extends StatefulWidget {
  const BookLaundryScreen({super.key});

  @override
  State<BookLaundryScreen> createState() => _BookLaundryScreenState();
}

class _BookLaundryScreenState extends State<BookLaundryScreen> {
  DateTime pickedDate = DateTime.now().toNextHalf();
  WashType? pickedType;
  int? pickedTemperature;

  final DateFormat dateFormat = DateFormat("EEE, d MMM");

  bool get canBook => pickedType != null && pickedTemperature != null;

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
                  '\$ 0.5/h',
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
              selectedValue: pickedType,
              values: WashType.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.label).tr(),
                      ))
                  .toList(),
              onChanged: (type) {
                if (pickedType != type) {
                  pickedType = type;
                  setState(() {});
                }
              },
              hintText: 'Choose type of wash',
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              leading: const Icon(Icons.list),
            ),
            StyledDropdownButton(
              selectedValue: pickedTemperature,
              values: getWashTemperatures()
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text('$e °C'),
                      ))
                  .toList(),
              onChanged: (temp) {
                if (pickedTemperature != temp) {
                  pickedTemperature = temp;
                  setState(() {});
                }
              },
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
                    '\$ ${_calculateCost()}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: canBook ? () {} : null,
                child: const Center(
                    child: Text(
                  'Book machine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )))
          ],
        ),
      ),
    );
  }

  double _calculateCost() {
    if (pickedType != null) {
      return (pickedType!.duration.inMinutes / 60) * 0.5;
    }
    return 0;
  }
}

enum WashType {
  fast(Duration(hours: 1), 'washtype_fast'),
  normal(Duration(hours: 1, minutes: 30), 'washtype_normal'),
  delicate(Duration(hours: 2), 'washtype_delicate');

  const WashType(this.duration, this.label);

  final Duration duration;
  final String label;
}

List<int> getWashTemperatures() {
  return [
    30,
    40,
    50,
    60,
    70,
  ];
}
