import 'package:cloud_firestore/cloud_firestore.dart';

import 'floor_entity.dart';

class Dorm {
  final DocumentReference<Map<String, dynamic>> selfReference;
  final String name;
  final List<Floor>? floors;

  Dorm({
    required this.selfReference,
    required this.name,
    this.floors,
  });

  bool get isEmpty => floors == null;

  Dorm.fromJson(Map<String, Object?> json, DocumentReference<Map<String, dynamic>> reference)
      : this(
          name: json['name']! as String,
          floors: (json['floors'] as List<dynamic>?)?.map((e) => Floor.fromJsonSimple(e)).toList(),
          selfReference: reference,
        );

  Dorm.fromJsonSimple(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          selfReference: json['selfReference'] as DocumentReference<Map<String, dynamic>>,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      if (floors != null) 'floors': floors?.map((e) => e.toJson()).toList(),
      if (isEmpty) 'selfReference': selfReference,
    };
  }

  Map<String, Object?> toSimpleJson() {
    return {
      'name': name,
      'selfReference': selfReference,
    };
  }

  @override
  String toString() {
    return 'Dorm $name with ${floors?.length ?? 'undefined'} floors';
  }
}
