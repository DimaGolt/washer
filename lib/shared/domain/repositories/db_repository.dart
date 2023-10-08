import 'package:washu/shared/data/mixed/mixed_db_repository.dart';

abstract class DbRepository {
  getDorms();
  getFloors();
  getLaundromats();

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
