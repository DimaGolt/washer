import 'package:washer/shared/domain/entities/reservation_entity.dart';

class FireUser {
  final String userId;
  final List<Reservation> reservations;

  FireUser({
    required this.userId,
    this.reservations = const [],
  });

  FireUser.fromJson(Map<String, dynamic>? json, String userId)
      : this(
          userId: userId,
          reservations: (json?['reservations'] as List<dynamic>?)
                  ?.map((e) => Reservation.fromJsonSimple(e))
                  .toList() ??
              [],
        );

  Map<String, Object?> toJson() {
    return {
      'reservations': reservations.map((e) => e.toSimpleJson()),
    };
  }

  @override
  String toString() {
    return 'FireUser';
  }
}
