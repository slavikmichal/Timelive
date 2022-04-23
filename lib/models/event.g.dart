// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      json['name'] as String,
      json['description'] as String,
      DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
    };
