import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:washer/shared/utils/reservation_time.dart';

Future<ReservationTime?> showLaundryTimePicker({
  required BuildContext context,
  required ReservationTime initialDate,
  required List<ReservationTime> reservedTimes,
}) async {
  return showDialog<ReservationTime>(
    context: context,
    builder: (BuildContext context) {
      return LaundryTimePicker(
        initialDate: initialDate,
        reservedTimes: reservedTimes,
      );
    },
  );
}

class LaundryTimePicker extends StatefulWidget {
  const LaundryTimePicker({super.key, required this.initialDate, required this.reservedTimes});

  final ReservationTime initialDate;
  final List<ReservationTime> reservedTimes;

  @override
  State<LaundryTimePicker> createState() => _LaundryTimePickerState();
}

class _LaundryTimePickerState extends State<LaundryTimePicker> {
  late List<ReservationTime> times = generateTimes(widget.initialDate);

  final ScrollController _controller = ScrollController();

  late ReservationTime _pickedTime;

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
    times.replaceReserved(widget.reservedTimes);
    _pickedTime = times.closest(widget.initialDate);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animateToIndex(times.indexOf(_pickedTime));
    });
  }

  void _handleOk() {
    Navigator.pop(context, _pickedTime);
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
                initialDate: widget.initialDate.time,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 7)),
                onDateChanged: (val) {
                  _pickedTime = _pickedTime.copyWith(month: val.month, day: val.day);
                  times = generateTimes(_pickedTime);
                  times.replaceReserved(widget.reservedTimes);
                  setState(() {});
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
              ReservationTime time = times[index];
              return InkWell(
                onTap: time.isReserved
                    ? null
                    : () {
                        _pickedTime = time;
                        setState(() {});
                      },
                child: Card(
                  elevation: 5,
                  color: _cardColor(time, context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(time.toStringHour()),
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

  Color? _cardColor(ReservationTime time, BuildContext context) {
    if (!time.isReserved) {
      return time == _pickedTime ? Theme.of(context).primaryColor : null;
    } else {
      return Colors.grey;
    }
  }

  _actions() {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      child: OverflowBar(
        spacing: 8,
        children: <Widget>[
          TextButton(
            onPressed: _handleCancel,
            child: const Text('cancel').tr(),
          ),
          TextButton(
            onPressed: _handleOk,
            child: const Text('ok').tr(),
          ),
        ],
      ),
    );
  }
}
