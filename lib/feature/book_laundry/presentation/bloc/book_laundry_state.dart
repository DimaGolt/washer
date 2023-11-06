part of 'book_laundry_bloc.dart';

enum BookLaundryStatus { initial, loadedDorms, pickedDorm, pickedFloor, pickedMachine, failure }

final class BookLaundryState extends Equatable {
  BookLaundryState({
    this.status = BookLaundryStatus.initial,
    this.dorms = const [],
    this.floors = const [],
    this.laundromats = const [],
    this.selectedDorm,
    this.selectedFloor,
    this.selectedLaundromat,
  });

  final BookLaundryStatus status;
  final List<Dorm> dorms;
  final List<Floor> floors;
  final List<Laundromat> laundromats;
  Dorm? selectedDorm;
  Floor? selectedFloor;
  Laundromat? selectedLaundromat;

  BookLaundryState copyWith({
    BookLaundryStatus? status,
    List<Dorm>? dorms,
    List<Floor>? floors,
    List<Laundromat>? laundromats,
    Dorm? selectedDorm,
    Floor? selectedFloor,
    Laundromat? selectedLaundromat,
  }) {
    return BookLaundryState(
      status: status ?? this.status,
      dorms: dorms ?? this.dorms,
      floors: floors ?? this.floors,
      laundromats: laundromats ?? this.laundromats,
      selectedDorm: selectedDorm,
      selectedFloor: selectedFloor,
      selectedLaundromat: selectedLaundromat,
    );
  }

  @override
  List<Object?> get props => [
        status,
        dorms,
        floors,
        laundromats,
        selectedDorm,
        selectedFloor,
        selectedLaundromat,
      ];
}
