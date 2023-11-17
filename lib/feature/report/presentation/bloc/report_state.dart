part of 'report_bloc.dart';

enum ReportStatus { initial, loadedDorms, pickedDorm, pickedFloor, pickedMachine, failure, done }

final class ReportState extends Equatable {
  ReportState({
    this.status = ReportStatus.initial,
    this.dorms = const [],
    this.floors = const [],
    this.laundromats = const [],
    this.selectedDorm,
    this.selectedFloor,
    this.selectedLaundromat,
    this.descriptionEnabled = true,
    this.description = '',
  });

  final ReportStatus status;
  final List<Dorm> dorms;
  final List<Floor> floors;
  final List<Laundromat> laundromats;
  Dorm? selectedDorm;
  Floor? selectedFloor;
  Laundromat? selectedLaundromat;
  bool descriptionEnabled;
  String description;

  bool get readyToReport =>
      selectedDorm != null && selectedFloor != null && selectedLaundromat != null;

  ReportState copyWith({
    ReportStatus? status,
    List<Dorm>? dorms,
    List<Floor>? floors,
    List<Laundromat>? laundromats,
    Dorm? selectedDorm,
    Floor? selectedFloor,
    Laundromat? selectedLaundromat,
    bool? descriptionEnabled,
    String? description,
  }) {
    return ReportState(
      status: status ?? this.status,
      dorms: dorms ?? this.dorms,
      floors: floors ?? this.floors,
      laundromats: laundromats ?? this.laundromats,
      selectedDorm: selectedDorm,
      selectedFloor: selectedFloor,
      selectedLaundromat: selectedLaundromat,
      descriptionEnabled: descriptionEnabled ?? this.descriptionEnabled,
      description: description ?? this.description,
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
        descriptionEnabled,
        description,
      ];
}
