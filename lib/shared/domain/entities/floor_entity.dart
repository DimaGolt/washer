import 'package:cloud_firestore/cloud_firestore.dart';

import 'dorm_entity.dart';
import 'laundromat_entity.dart';

class Floor {
  final DocumentReference<Map<String, dynamic>>? selfReference;
  final int level;
  final Dorm? dorm;
  final List<Laundromat>? laundromats;

  Floor({
    this.selfReference,
    required this.level,
    this.dorm,
    this.laundromats,
  });

  bool get isEmpty => dorm == null && selfReference != null;

  Floor.fromJson(Map<String, Object?> json)
      : this(
          selfReference: json['selfReference'] as DocumentReference<Map<String, dynamic>>?,
          level: json['level']! as int,
          dorm: json['dorm'] != null ? Dorm.fromJson(json['dorm'] as Map<String, Object?>) : null,
          laundromats: json['laundromats'] != null
              ? (json['laundromats'] as List<dynamic>).map((e) => Laundromat.fromJson(e)).toList()
              : null,
        );

  Map<String, Object?> toJson() {
    return {
      'level': level,
      if (dorm != null) 'dorm': dorm?.toJson(),
      if (laundromats != null) 'laundromats': laundromats?.map((e) => e.toJson()),
      if (selfReference != null) 'selfReference': selfReference,
    };
  }

  @override
  String toString() {
    return 'Floor in ${dorm?.name ?? 'undefined'} on level $level containing ${laundromats?.length ?? 'undefined'} laundromats';
  }
}
