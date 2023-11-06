import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:washu/shared/domain/entities/dorm_entity.dart';
import 'package:washu/shared/domain/entities/laundromat_entity.dart';
import 'package:washu/shared/domain/repositories/db_repository.dart';

import '../../domain/entities/floor_entity.dart';

class MixedDbRepository implements DbRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<Dorm>> getDorms() async {
    var foo = await _db.collection('dorms').get();
    var foo2 = foo.docs.map((dorm) => Dorm.fromJson(dorm.data())).toList();
    return foo2;
  }

  @override
  Future<List<Laundromat>> getFloorLaundromats(Floor floor) async {
    Floor parent = floor;
    if (parent.isEmpty) {
      var json = await floor.selfReference!.get();
      if (json.exists) {
        parent = Floor.fromJson(json.data()!);
      } else {
        throw DatabaseException(message: 'Couldn\'t find this floor');
      }
    }

    List<Laundromat> result = [];
    for (Laundromat laundromat in parent.laundromats!) {
      var json = await laundromat.selfReference!.get();
      if (json.exists) {
        Laundromat full = Laundromat.fromJson(json.data()!);
        result.add(full);
      }
    }

    return result;
  }

  @override
  Future<List<Floor>> getDormFloors(Dorm dorm) async {
    Dorm parent = dorm;
    if (parent.isEmpty) {
      var json = await dorm.selfReference!.get();
      if (json.exists) {
        parent = Dorm.fromJson(json.data()!);
      } else {
        throw DatabaseException(message: 'Couldn\'t find this dorm');
      }
    }

    List<Floor> result = [];
    for (Floor floor in parent.floors!) {
      var json = await floor.selfReference!.get();
      if (json.exists) {
        Floor full = Floor.fromJson(json.data()!);
        result.add(full);
      }
    }

    return result;
  }

  @override
  Future<List<Floor>> getFloors() async {
    var foo = await _db.collection('floors').get();
    var foo2 = foo.docs.map((dorm) => Floor.fromJson(dorm.data())).toList();
    return foo2;
  }

  @override
  Future<List<Laundromat>> getLaundromats() async {
    var foo = await _db.collection('laundromats').get();
    var foo2 = foo.docs.map((dorm) => Laundromat.fromJson(dorm.data())).toList();
    return foo2;
  }
}
