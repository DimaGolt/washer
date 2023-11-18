import 'package:washer/shared/domain/entities/dorm_entity.dart';
import 'package:washer/shared/domain/entities/reservation_entity.dart';

class FireUser {
  final String userId;
  final List<Reservation> reservations;
  Dorm? favDorm;

  FireUser({
    required this.userId,
    this.reservations = const [],
    this.favDorm,
  });

  FireUser.fromJson(Map<String, dynamic>? json, String userId)
      : this(
          userId: userId,
          reservations: (json?['reservations'] as List<dynamic>?)
                  ?.map((e) => Reservation.fromJsonSimple(e))
                  .toList() ??
              [],
          favDorm: (json?['favDorm'] as Map<String, dynamic>?) != null
              ? Dorm.fromJsonSimple(json?['favDorm'])
              : null,
        );

  Map<String, Object?> toJson() {
    return {
      'reservations': reservations.map((e) => e.toSimpleJson()),
      if (favDorm != null) 'favDorm': favDorm!.toSimpleJson(),
    };
  }

  @override
  String toString() {
    return 'FireUser';
  }
}
