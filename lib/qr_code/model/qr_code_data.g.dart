// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeData _$QrCodeDataFromJson(Map<String, dynamic> json) => QrCodeData(
      json['eventId'] as String,
      DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$QrCodeDataToJson(QrCodeData instance) => <String, dynamic>{
      'eventId': instance.eventId,
      'created': instance.created.toIso8601String(),
    };
