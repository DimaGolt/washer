part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReportStart extends ReportEvent {}

class ReportPickDorm extends ReportEvent {
  final Dorm dorm;

  const ReportPickDorm(this.dorm);

  @override
  List<Object?> get props => [dorm];
}

class ReportPickFloor extends ReportEvent {
  final Floor floor;

  const ReportPickFloor(this.floor);

  @override
  List<Object?> get props => [floor];
}

class ReportSwitchDesc extends ReportEvent {
  const ReportSwitchDesc();

  @override
  List<Object?> get props => [];
}

class ReportPickMachine extends ReportEvent {
  final Laundromat laundromat;

  const ReportPickMachine(this.laundromat);

  @override
  List<Object?> get props => [laundromat];
}

class ReportSend extends ReportEvent {
  final Report report;
  final String userId;

  const ReportSend(this.report, this.userId);

  @override
  List<Object?> get props => [report, userId];
}

class ReportUpdateDescription extends ReportEvent {
  final String description;

  const ReportUpdateDescription(this.description);

  @override
  List<Object?> get props => [description];
}
