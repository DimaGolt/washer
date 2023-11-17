import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:washer/shared/domain/entities/laundromat_entity.dart';

class Report {
  final Laundromat laundromat;
  final String description;
  final DateTime timestamp;

  Report({
    required this.laundromat,
    required this.description,
    required this.timestamp,
  });

  Map<String, Object?> toJson() {
    return {
      'dorm': laundromat.dorm!.selfReference,
      'floor': laundromat.floor!.selfReference,
      'laundromat': laundromat.selfReference,
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  @override
  String toString() {
    return 'Report for machine nr ${laundromat.number} in ${laundromat.dorm?.name} at floor ${laundromat.floor?.level}';
  }
}
