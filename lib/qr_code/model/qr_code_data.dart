import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timelive/models/tag.dart';

part 'qr_code_data.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class QrCodeData {
  @JsonKey(name: 'eventId')
  final String eventId;
  @JsonKey(name: 'created')
  final DateTime created;

  const QrCodeData(this.eventId, this.created);

  factory QrCodeData.fromJson(Map<String, dynamic> json) => _$QrCodeDataFromJson(json);

  Map<String, dynamic> toJson() => _$QrCodeDataToJson(this);
}
