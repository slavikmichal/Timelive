import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timelive/models/tag.dart';

part 'event.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Event {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(name: 'tags')
  final List<Tag> tags;

  const Event(this.id, this.name, this.description, this.date, this.tags);

  factory Event.fromJson(String id, Map<String, dynamic> json) {
    json['id'] = id;
    return _$EventFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
