import 'package:flutter/material.dart';
import 'package:washu/shared/utils/datetime.dart';

Future<DateTime?> showLaundryTimePicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return LaundryTimePicker(initialDate: initialDate);
    },
  );
}

class LaundryTimePicker extends StatefulWidget {
  const LaundryTimePicker({super.key, required this.initialDate});

  final DateTime initialDate;

  @override
  State<LaundryTimePicker> createState() => _LaundryTimePickerState();
}

class _LaundryTimePickerState extends State<LaundryTimePicker> {
  List<DateTime> times = generateTimes();

  final ScrollController _controller = ScrollController();

  late DateTime _pickedDate;
  late DateTime _pickedTime;

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * 66,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _pickedDate = widget.initialDate;
    _pickedTime = times.closest(_pickedDate);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animateToIndex(times.indexOf(_pickedTime));
    });
  }

  void _handleOk() {
    DateTime combinedTime =
        _pickedDate.copyWith(hour: _pickedTime.hour, minute: _pickedTime.minute);
    Navigator.pop(context, combinedTime);
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 336,
        height: 536,
        child: Column(
          children: [
            CalendarDatePicker(
                initialDate: widget.initialDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 7)),
                onDateChanged: (val) {
                  _pickedDate = val;
                }),
            _timePicker(),
            _actions(),
          ],
        ),
      ),
    );
  }

  _timePicker() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  _pickedTime = times[index];
                  setState(() {});
                },
                child: Card(
                  elevation: 5,
                  color: times[index] == _pickedTime ? Theme.of(context).primaryColor : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                            '${times[index].hour.toString().padLeft(2, '0')}:${times[index].minute.toString().padLeft(2, '0')}'),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _actions() {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      child: OverflowBar(
        spacing: 8,
        children: <Widget>[
          TextButton(
            onPressed: _handleCancel,
            child: Text('Cancel'), //TODO: translate
          ),
          TextButton(
            onPressed: _handleOk,
            child: Text('Ok'), //TODO: translate
          ),
        ],
      ),
    );
  }
}
