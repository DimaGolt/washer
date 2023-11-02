import 'package:cloud_firestore/cloud_firestore.dart';

import 'floor_entity.dart';
import 'dorm_entity.dart';

class Laundromat {
  final DocumentReference<Map<String, dynamic>>? selfReference;
  final Dorm? dorm;
  final Floor? floor;
  final int? number;

  Laundromat({
    this.selfReference,
    this.dorm,
    this.floor,
    this.number,
  });

  bool get isEmpty => floor == null && dorm == null && selfReference != null;

  Laundromat.fromJson(Map<String, Object?> json)
      : this(
          selfReference: json['selfReference'] as DocumentReference<Map<String, dynamic>>?,
          dorm: json['dorm'] != null ? Dorm.fromJson(json['dorm']! as Map<String, Object?>) : null,
          floor:
              json['floor'] != null ? Floor.fromJson(json['floor']! as Map<String, Object?>) : null,
          number: json['number'] as int?,
        );

  Map<String, Object?> toJson() {
    return {
      if (dorm != null) 'dorm': dorm?.toJson(),
      if (floor != null) 'floor': floor?.toJson(),
      if (selfReference != null) 'selfReference': selfReference,
      if (number != null) 'number': number,
    };
  }

  @override
  String toString() {
    return 'Laundromat ${number ?? 'undefined'} in ${dorm?.name ?? 'undefined'} on ${floor?.level ?? 'undefined'} floor';
  }
}
