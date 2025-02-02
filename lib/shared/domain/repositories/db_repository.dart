import 'package:washer/shared/domain/entities/fire_user_entity.dart';
import 'package:washer/shared/domain/entities/reservation_entity.dart';

import '../../../feature/report/domain/entities/report.dart';
import '../../data/mixed/mixed_db_repository.dart';
import '../../utils/reservation_time.dart';
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
  Future<FireUser> getFireUser(String userId);
  Future<void> createFireUser(String userId);
  Future<void> changeFavDorm(Dorm dorm, String userId);
  Future<Reservation?> checkActiveLaundry(String userId);
  Future<List<ReservationTime>> getReservedTimesForLaundromat(Laundromat laundromat);

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
