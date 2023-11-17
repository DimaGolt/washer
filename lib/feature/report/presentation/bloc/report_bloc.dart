import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:washer/feature/report/domain/entities/report.dart';

import '../../../../shared/domain/entities/dorm_entity.dart';
import '../../../../shared/domain/entities/floor_entity.dart';
import '../../../../shared/domain/entities/laundromat_entity.dart';
import '../../../../shared/domain/repositories/db_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final DbRepository dbRepository;

  ReportBloc({required this.dbRepository}) : super(ReportState()) {
    on<ReportStart>(_fetchDorms);
    on<ReportPickDorm>(_fetchFloors);
    on<ReportPickFloor>(_fetchLaundromats);
    on<ReportPickMachine>(_setMachine);
    on<ReportSend>(_sendReport);
    on<ReportSwitchDesc>(_switchDescription);
    on<ReportUpdateDescription>(_updateDescription);
  }

  _fetchDorms(ReportStart event, Emitter<ReportState> emit) async {
    emit(ReportState());
    final dorms = await dbRepository.getDorms();
    emit(state.copyWith(status: ReportStatus.loadedDorms, dorms: dorms));
  }

  _fetchFloors(ReportPickDorm event, Emitter<ReportState> emit) async {
    final floors = await dbRepository.getDormFloors(event.dorm);
    emit(state.copyWith(
      status: ReportStatus.pickedDorm,
      floors: floors,
      selectedDorm: event.dorm,
    ));
  }

  _fetchLaundromats(ReportPickFloor event, Emitter<ReportState> emit) async {
    final List<Laundromat> laundromats = await dbRepository.getFloorLaundromats(event.floor);
    laundromats.sort((a, b) => a.number!.compareTo(b.number!));
    emit(state.copyWith(
      status: ReportStatus.pickedFloor,
      laundromats: laundromats,
      selectedDorm: state.selectedDorm,
      selectedFloor: event.floor,
    ));
  }

  _setMachine(ReportPickMachine event, Emitter<ReportState> emit) {
    emit(state.copyWith(
      status: ReportStatus.pickedMachine,
      selectedDorm: state.selectedDorm,
      selectedFloor: state.selectedFloor,
      selectedLaundromat: event.laundromat,
    ));
  }

  _switchDescription(ReportSwitchDesc event, Emitter<ReportState> emit) {
    emit(state.copyWith(
      status: ReportStatus.pickedMachine,
      selectedDorm: state.selectedDorm,
      selectedFloor: state.selectedFloor,
      selectedLaundromat: state.selectedLaundromat,
      descriptionEnabled: !state.descriptionEnabled,
    ));
  }

  _updateDescription(ReportUpdateDescription event, Emitter<ReportState> emit) {
    emit(state.copyWith(
      status: ReportStatus.pickedMachine,
      selectedDorm: state.selectedDorm,
      selectedFloor: state.selectedFloor,
      selectedLaundromat: state.selectedLaundromat,
      description: event.description,
    ));
  }

  _sendReport(ReportSend event, Emitter<ReportState> emit) async {
    await dbRepository.sendReport(event.report, event.userId);
    emit(ReportState(status: ReportStatus.done));
    emit(ReportState(status: ReportStatus.initial));
  }
}
