import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washu/shared/domain/repositories/db_repository.dart';

import '../../../../shared/domain/entities/dorm_entity.dart';
import '../../../../shared/domain/entities/floor_entity.dart';
import '../../../../shared/domain/entities/laundromat_entity.dart';

part 'book_laundry_event.dart';

part 'book_laundry_state.dart';

part 'book_laundry_bloc.freezed.dart';

class BookLaundryBloc extends Bloc<BookLaundryEvent, BookLaundryState> {
  final DbRepository dbRepository;

  BookLaundryBloc({required this.dbRepository}) : super(const BookLaundryState.initial()) {
    on<BookLaundryEvent>((event, emit) async {
      await event.map(
        started: (_) async => await _fetchDorms(emit),
        pickDorm: (event) async => await _fetchFloors(event, emit),
        pickFloor: (event) async => await _fetchLaundromats(event, emit),
      );
    });
  }

  _fetchDorms(Emitter<BookLaundryState> emit) async {
    final dorms = await dbRepository.getDorms();
    emit(LoadedDorms(dorms));
  }

  _fetchFloors(PickDorm event, Emitter<BookLaundryState> emit) async {
    final floors = await dbRepository.getDormFloors(event.dorm);
    emit(PickedDorm(floors));
  }

  _fetchLaundromats(PickFloor event, Emitter<BookLaundryState> emit) async {
    final List<Laundromat> laundromats = await dbRepository.getFloorLaundromats(event.floor);
    emit(PickedFloor(laundromats));
  }
}
