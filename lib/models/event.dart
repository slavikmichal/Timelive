
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Event {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'date')
  final DateTime date;

  Event(this.name, this.description, this.date);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}