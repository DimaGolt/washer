import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:washer/shared/domain/entities/reservation_entity.dart';

import '../../../../shared/domain/entities/dorm_entity.dart';
import '../../../../shared/domain/entities/floor_entity.dart';
import '../../../../shared/domain/entities/laundromat_entity.dart';
import '../../../../shared/domain/repositories/db_repository.dart';

part 'book_laundry_event.dart';

part 'book_laundry_state.dart';

class BookLaundryBloc extends Bloc<BookLaundryEvent, BookLaundryState> {
  final DbRepository dbRepository;

  BookLaundryBloc({required this.dbRepository}) : super(BookLaundryState()) {
    on<BookLaundryStart>(_fetchDorms);
    on<BookLaundryPickDorm>(_fetchFloors);
    on<BookLaundryPickFloor>(_fetchLaundromats);
    on<BookLaundryPickMachine>(_setMachine);
    on<BookLaundryReservation>(_bookReservation);
  }

  _fetchDorms(BookLaundryStart event, Emitter<BookLaundryState> emit) async {
    emit(BookLaundryState());
    final dorms = await dbRepository.getDorms();
    emit(state.copyWith(status: BookLaundryStatus.loadedDorms, dorms: dorms));
  }

  _fetchFloors(BookLaundryPickDorm event, Emitter<BookLaundryState> emit) async {
    final floors = await dbRepository.getDormFloors(event.dorm);
    emit(state.copyWith(
      status: BookLaundryStatus.pickedDorm,
      floors: floors,
      selectedDorm: event.dorm,
    ));
  }

  _fetchLaundromats(BookLaundryPickFloor event, Emitter<BookLaundryState> emit) async {
    final List<Laundromat> laundromats = await dbRepository.getFloorLaundromats(event.floor);
    laundromats.sort((a, b) => a.number!.compareTo(b.number!));
    emit(state.copyWith(
      status: BookLaundryStatus.pickedFloor,
      laundromats: laundromats,
      selectedDorm: state.selectedDorm,
      selectedFloor: event.floor,
    ));
  }

  _setMachine(BookLaundryPickMachine event, Emitter<BookLaundryState> emit) {
    emit(state.copyWith(
      status: BookLaundryStatus.pickedMachine,
      selectedDorm: state.selectedDorm,
      selectedFloor: state.selectedFloor,
      selectedLaundromat: event.laundromat,
    ));
  }

  fetchReservations() {
    dbRepository.getReservations();
  }

  _bookReservation(BookLaundryReservation event, Emitter<BookLaundryState> emit) {
    dbRepository.bookReservation(event.reservation, event.userId);
  }
}
