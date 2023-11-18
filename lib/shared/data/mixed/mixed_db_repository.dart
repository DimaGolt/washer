import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:washer/feature/report/domain/entities/report.dart';
import 'package:washer/shared/domain/entities/fire_user_entity.dart';
import 'package:washer/shared/domain/entities/reservation_entity.dart';

import '../../domain/entities/dorm_entity.dart';
import '../../domain/entities/floor_entity.dart';
import '../../domain/entities/laundromat_entity.dart';
import '../../domain/repositories/db_repository.dart';

class MixedDbRepository implements DbRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<Dorm>> getDorms() async {
    var foo = await _db.collection('dorms').get();
    var foo2 = foo.docs.map((dorm) => Dorm.fromJson(dorm.data(), dorm.reference)).toList();
    return foo2;
  }

  @override
  Future<List<Laundromat>> getFloorLaundromats(Floor floor) async {
    Floor parent = floor;
    if (parent.isEmpty) {
      var json = await floor.selfReference.get();
      if (json.exists) {
        parent = Floor.fromJson(json.data()!, floor.selfReference);
      } else {
        throw DatabaseException(message: 'Couldn\'t find this floor');
      }
    }

    List<Laundromat> result = [];
    for (Laundromat laundromat in parent.laundromats!) {
      var json = await laundromat.selfReference.get();
      if (json.exists) {
        Laundromat full = Laundromat.fromJson(json.data()!, laundromat.selfReference);
        result.add(full);
      }
    }

    return result;
  }

  @override
  Future<List<Floor>> getDormFloors(Dorm dorm) async {
    Dorm parent = dorm;
    if (parent.isEmpty) {
      var json = await dorm.selfReference.get();
      if (json.exists) {
        parent = Dorm.fromJson(json.data()!, dorm.selfReference);
      } else {
        throw DatabaseException(message: 'Couldn\'t find this dorm');
      }
    }

    List<Floor> result = [];
    for (Floor floor in parent.floors!) {
      var json = await floor.selfReference.get();
      if (json.exists) {
        Floor full = Floor.fromJson(json.data()!, floor.selfReference);
        result.add(full);
      }
    }

    return result;
  }

  @override
  Future<List<Floor>> getFloors() async {
    var foo = await _db.collection('floors').get();
    var foo2 = foo.docs.map((floor) => Floor.fromJson(floor.data(), floor.reference)).toList();
    return foo2;
  }

  @override
  Future<List<Laundromat>> getLaundromats() async {
    var foo = await _db.collection('laundromats').get();
    var foo2 = foo.docs
        .map((laundromat) => Laundromat.fromJson(laundromat.data(), laundromat.reference))
        .toList();
    return foo2;
  }

  @override
  Future<List<Reservation>> getReservations() async {
    var foo = await _db.collection('reservations').get();
    var foo2 = foo.docs
        .map((reservation) => Reservation.fromJson(reservation.data(), reservation.reference))
        .toList();
    print(foo2.first.toJson().toString());
    return foo2;
  }

  @override
  Future<void> bookReservation(Reservation reservation, String userId) async {
    if (reservation.isBookable) {
      DocumentReference<Map<String, dynamic>> reference = await _db
          .collection('reservations')
          .add(reservation.toJson()..addAll({'userId': userId}));
      reservation.selfReference = reference;
      DocumentSnapshot<Map<String, dynamic>> result =
          await _db.collection('users').doc(userId).get();
      FireUser user = FireUser.fromJson(result.data(), userId);
      user.reservations.add(reservation);
      result.reference.update(user.toJson());
    }
  }

  @override
  Future<void> deleteReservation(Reservation reservation, String userId) async {
    reservation.selfReference?.delete();
    DocumentSnapshot<Map<String, dynamic>> result = await _db.collection('users').doc(userId).get();
    FireUser user = FireUser.fromJson(result.data(), userId);
    user.reservations.removeWhere((element) => element == reservation);
    result.reference.update(user.toJson());
  }

  @override
  Future<List<Reservation>> getUserReservations(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _db.collection('users').doc(userId).get();

    FireUser user = FireUser.fromJson(userDoc.data(), userId);
    List<Reservation> reservations = [];
    for (Reservation e in user.reservations) {
      var result = await e.selfReference!.get();
      Reservation reservation = Reservation.fromJson(result.data(), result.reference);
      reservations.add(reservation);
    }
    return reservations;
  }

  @override
  Future<void> sendReport(Report report, String userId) async {
    await _db.collection('reports').add(report.toJson());
  }

  @override
  Future<FireUser> getFireUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _db.collection('users').doc(userId).get();

    FireUser user = FireUser.fromJson(userDoc.data(), userId);
    return user;
  }
}
