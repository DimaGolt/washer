extension MyDateUtils on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime toNextHalf() {
    DateTime returnable = this;
    if (returnable.minute == 0) {
      returnable = this;
    } else if (minute <= 30) {
      returnable = copyWith(minute: 30);
    } else if (minute < 60) {
      returnable = copyWith(minute: 0, hour: hour + 1);
    } else {
      returnable = this;
    }

    if (hour >= 21) {
      returnable = copyWith(day: day + 1, hour: 7, minute: 0);
    } else if (hour < 7) {
      returnable = copyWith(hour: 7, minute: 0);
    }
    return returnable;
  }
}

extension DateListUtils on List<DateTime> {
  DateTime closest(DateTime time) {
    return reduce((a, b) => a.difference(time).abs() < b.difference(time).abs() ? a : b);
  }
}

List<DateTime> generateTimes(DateTime initialDate) {
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
