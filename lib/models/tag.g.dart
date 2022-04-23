// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      json['id'] as String,
      json['name'] as String,
      json['counter'] as int,
      json['color'] as int,
    );

Map<String, dynamic> _$TagToJson(Tag instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'counter': instance.counter,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('color', instance.color);
  return val;
}
