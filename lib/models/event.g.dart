// GENERATED CODE

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      json['id'] as String?,
      json['name'] as String,
      json['description'] as String,
      DateTime.fromMillisecondsSinceEpoch((json['date'] as Timestamp).millisecondsSinceEpoch), //TODO: FIX CORRECT AUTO GENERATION
      (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['description'] = instance.description;
  val['date'] = instance.date.toIso8601String();
  val['tags'] = instance.tags.map((e) => e.toJson()).toList();
  return val;
}
