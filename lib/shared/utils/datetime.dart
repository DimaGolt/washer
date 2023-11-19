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
