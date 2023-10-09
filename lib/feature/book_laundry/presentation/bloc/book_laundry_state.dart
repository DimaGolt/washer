part of 'book_laundry_bloc.dart';

@freezed
class BookLaundryState with _$BookLaundryState {
  const factory BookLaundryState.initial() = Initial;
  const factory BookLaundryState.loadedDorms(List<Dorm> dorms) = LoadedDorms;
  const factory BookLaundryState.pickedDorm(List<Floor> floor) = PickedDorm;
  const factory BookLaundryState.pickedFloor(List<Laundromat> laundromats) = PickedFloor;
}
