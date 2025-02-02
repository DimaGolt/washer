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

class BookLaundryPickMachine extends BookLaundryEvent {
  final Laundromat laundromat;

  const BookLaundryPickMachine(this.laundromat);

  @override
  List<Object?> get props => [laundromat];
}

class BookLaundryReservation extends BookLaundryEvent {
  final Reservation reservation;
  final String userId;

  const BookLaundryReservation(this.reservation, this.userId);

  @override
  List<Object?> get props => [reservation, userId];
}
