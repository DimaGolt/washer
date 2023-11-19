import 'package:easy_localization/easy_localization.dart';

import '../domain/entities/reservation_entity.dart';

class ReservationTime {
  final DateTime time;
  bool isReserved;

  ReservationTime({
    required this.time,
    this.isReserved = false,
  }) : assert(time.minute == 30 || time.minute == 0);

  static List<ReservationTime> fromReservation(Reservation reservation) {
    DateTime startTime = reservation.start!;
    DateTime endTime = reservation.end!.add(const Duration(minutes: 30));
    List<ReservationTime> times = [];

    ReservationTime helper = ReservationTime(time: startTime, isReserved: true);
    while (helper.time != endTime) {
      times.add(helper);
      if (helper.time.minute == 30) {
        helper = helper.copyWith(hour: helper.time.hour + 1, minute: 0);
      } else {
        helper = helper.copyWith(minute: 30);
      }
    }
    return times;
  }

  String toStringHour() {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String toStringDay() {
    DateFormat dateFormat = DateFormat("EEE, d MMM");
    return dateFormat.format(time);
  }

  @override
  String toString() {
    return time.toString();
  }

  ReservationTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    bool? isUtc,
    bool? isReserved,
  }) {
    return ReservationTime(
        time: ((isUtc ?? time.isUtc) ? DateTime.utc : DateTime.new)(
          year ?? time.year,
          month ?? time.month,
          day ?? time.day,
          hour ?? time.hour,
          minute ?? time.minute,
          second ?? time.second,
          millisecond ?? time.millisecond,
          microsecond ?? time.microsecond,
        ),
        isReserved: isReserved ?? this.isReserved);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationTime &&
          runtimeType == other.runtimeType &&
          time.hour == other.time.hour &&
          time.minute == other.time.minute &&
          time.day == other.time.day &&
          time.month == other.time.month;

  @override
  int get hashCode => time.hashCode;
}

extension on ReservationTime {}

extension ReservationTimeListUtils on List<ReservationTime> {
  ReservationTime closest(ReservationTime time) {
    ReservationTime result = reduce(
        (a, b) => a.time.difference(time.time).abs() < b.time.difference(time.time).abs() ? a : b);
    while (result.isReserved) {
      int index = indexOf(result);
      if (index < length) {
        result = this[index + 1];
      }
    }
    return result;
  }

  void replaceReserved(
    List<ReservationTime> reservedTimes,
  ) {
    for (ReservationTime reservationTime in reservedTimes) {
      int indexToReplace = indexWhere((element) => element == reservationTime);
      if (indexToReplace != -1) {
        this[indexToReplace].isReserved = true;
      }
    }
  }
}

List<ReservationTime> generateTimes(ReservationTime initialDate) {
  return [
    initialDate.copyWith(hour: 7, minute: 00),
    initialDate.copyWith(hour: 7, minute: 30),
    initialDate.copyWith(hour: 8, minute: 00),
    initialDate.copyWith(hour: 8, minute: 30),
    initialDate.copyWith(hour: 9, minute: 00),
    initialDate.copyWith(hour: 9, minute: 30),
    initialDate.copyWith(hour: 10, minute: 00),
    initialDate.copyWith(hour: 10, minute: 30),
    initialDate.copyWith(hour: 11, minute: 00),
    initialDate.copyWith(hour: 11, minute: 30),
    initialDate.copyWith(hour: 12, minute: 00),
    initialDate.copyWith(hour: 12, minute: 30),
    initialDate.copyWith(hour: 13, minute: 00),
    initialDate.copyWith(hour: 13, minute: 30),
    initialDate.copyWith(hour: 14, minute: 00),
    initialDate.copyWith(hour: 14, minute: 30),
    initialDate.copyWith(hour: 15, minute: 00),
    initialDate.copyWith(hour: 15, minute: 30),
    initialDate.copyWith(hour: 16, minute: 00),
    initialDate.copyWith(hour: 16, minute: 30),
    initialDate.copyWith(hour: 17, minute: 00),
    initialDate.copyWith(hour: 17, minute: 30),
    initialDate.copyWith(hour: 18, minute: 00),
    initialDate.copyWith(hour: 18, minute: 30),
    initialDate.copyWith(hour: 19, minute: 00),
    initialDate.copyWith(hour: 19, minute: 30),
    initialDate.copyWith(hour: 20, minute: 00),
    initialDate.copyWith(hour: 20, minute: 30),
    initialDate.copyWith(hour: 21, minute: 00),
  ];
}
