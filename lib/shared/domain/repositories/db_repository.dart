import 'package:washer/shared/domain/entities/reservation_entity.dart';

import '../../../feature/report/domain/entities/report.dart';
import '../../data/mixed/mixed_db_repository.dart';
import '../entities/dorm_entity.dart';
import '../entities/floor_entity.dart';
import '../entities/laundromat_entity.dart';

abstract class DbRepository {
  Future<List<Dorm>> getDorms();
  Future<List<Floor>> getFloors();
  Future<List<Laundromat>> getLaundromats();
  Future<List<Reservation>> getReservations();
  Future<List<Laundromat>> getFloorLaundromats(Floor floor);
  Future<List<Floor>> getDormFloors(Dorm dorm);
  Future<void> bookReservation(Reservation reservation, String userId);
  Future<void> deleteReservation(Reservation reservation, String userId);
  Future<List<Reservation>> getUserReservations(String userId);
  Future<void> sendReport(Report reservation, String userId);

  static DbRepository build() => MixedDbRepository();
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException({required this.message});

  @override
  String toString() {
    return message;
  }
}
