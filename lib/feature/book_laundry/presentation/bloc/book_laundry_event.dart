part of 'book_laundry_bloc.dart';

abstract class BookLaundryEvent extends Equatable {
  const BookLaundryEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class BookLaundryStart extends BookLaundryEvent {}

class BookLaundryPickDorm extends BookLaundryEvent {
  final Dorm dorm;

  const BookLaundryPickDorm(this.dorm);

  @override
  List<Object?> get props => [dorm];
}

class BookLaundryPickFloor extends BookLaundryEvent {
  final Floor floor;

  const BookLaundryPickFloor(this.floor);

  @override
  List<Object?> get props => [floor];
}
