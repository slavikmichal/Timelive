import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'tag.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Tag {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'counter')
  final int counter;

  const Tag(this.id, this.name, this.counter);

  Tag.id(this.name, this.counter) : id = const Uuid().v4();

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}