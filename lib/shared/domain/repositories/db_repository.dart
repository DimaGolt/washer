import 'package:washu/shared/data/mixed/mixed_db_repository.dart';
import 'package:washu/shared/domain/entities/laundromat_entity.dart';

import '../entities/dorm_entity.dart';
import '../entities/floor_entity.dart';

abstract class DbRepository {
  Future<List<Dorm>> getDorms();
  Future<List<Floor>> getFloors();
  Future<List<Laundromat>> getLaundromats();
  Future<List<Laundromat>> getFloorLaundromats(Floor floor);
  Future<List<Floor>> getDormFloors(Dorm dorm);

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
