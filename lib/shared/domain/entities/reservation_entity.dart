import 'package:cloud_firestore/cloud_firestore.dart';

import 'dorm_entity.dart';
import 'floor_entity.dart';
import 'laundromat_entity.dart';

class Reservation {
  DocumentReference<Map<String, dynamic>>? selfReference;
  final Dorm? dorm;
  final Floor? floor;
  final Laundromat? laundromat;
  final DateTime? start;
  final DateTime? end;
  final int? temperature;
  final double? price;
  final String? washType;

  Reservation({
    this.selfReference,
    this.dorm,
    this.floor,
    this.laundromat,
    this.start,
    this.end,
    this.temperature,
    this.price,
    this.washType,
  });

  bool get isEmpty => dorm == null && selfReference != null;

  bool get isBookable =>
      dorm != null &&
      floor != null &&
      laundromat != null &&
      start != null &&
      end != null &&
      temperature != null &&
      price != null &&
      washType != null;

  Reservation.fromJson(Map<String, Object?> json, DocumentReference<Map<String, dynamic>> reference)
      : this(
          selfReference: reference,
          dorm: json['dorm'] != null
              ? Dorm.fromJsonSimple(json['dorm'] as Map<String, Object?>)
              : null,
          floor: json['floor'] != null
              ? Floor.fromJsonSimple(json['floor'] as Map<String, Object?>)
              : null,
          laundromat: json['laundromat'] != null
              ? Laundromat.fromJsonSimple(json['laundromat'] as Map<String, Object?>)
              : null,
          start: json['start'] != null ? (json['start'] as Timestamp).toDate() : null,
          end: json['end'] != null ? (json['end'] as Timestamp).toDate() : null,
          temperature: json['temperature'] as int?,
          price: json['price'] as double?,
          washType: json['washType'] as String?,
        );

  Reservation.fromJsonSimple(Map<String, Object?> json)
      : this(
          selfReference: json['selfReference'] as DocumentReference<Map<String, dynamic>>?,
          dorm: json['dorm'] != null
              ? Dorm.fromJsonSimple(json['dorm'] as Map<String, Object?>)
              : null,
          floor: json['floor'] != null
              ? Floor.fromJsonSimple(json['floor'] as Map<String, Object?>)
              : null,
          laundromat: json['laundromat'] != null
              ? Laundromat.fromJsonSimple(json['laundromat'] as Map<String, Object?>)
              : null,
          start: json['start'] != null ? (json['start'] as Timestamp).toDate() : null,
          end: json['end'] != null ? (json['end'] as Timestamp).toDate() : null,
          temperature: json['temperature'] as int?,
          price: json['price'] as double?,
          washType: json['washType'] as String?,
        );

  Map<String, Object?> toJson() {
    return {
      if (isEmpty) 'selfReference': selfReference,
      if (dorm != null) 'dorm': dorm?.toSimpleJson(),
      if (floor != null) 'floor': floor?.toSimpleJson(),
      if (laundromat != null) 'laundromat': laundromat?.toSimpleJson(),
      if (start != null) 'start': Timestamp.fromDate(start!),
      if (end != null) 'end': Timestamp.fromDate(end!),
      if (temperature != null) 'temperature': temperature,
      if (price != null) 'price': price,
      if (washType != null) 'washType': washType,
    };
  }

  Map<String, Object?> toSimpleJson() {
    return {
      'selfReference': selfReference,
    };
  }

  @override
  String toString() {
    return 'Reservation';
  }
}
