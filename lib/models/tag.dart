import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

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
  @JsonKey(name: 'color')
  final int color;

  const Tag(this.id, this.name, this.counter, this.color);

  Tag.id(this.name) : id = const Uuid().v4(), counter = 0, color = Colors.primaries[Random().nextInt(Colors.primaries.length)].value;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}