part of 'book_laundry_bloc.dart';

@freezed
class BookLaundryEvent with _$BookLaundryEvent {
  const factory BookLaundryEvent.started() = _Started;
  const factory BookLaundryEvent.pickDorm(Dorm dorm) = PickDorm;
  const factory BookLaundryEvent.pickFloor(Floor floor) = PickFloor;
}
