import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:math';

part 'tag.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Tag {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'counter')
  final int counter;
  @JsonKey(name: 'color')
  final int color;

  const Tag(this.name, this.counter, this.color);

  Tag.id(this.name) :
        counter = 0,
        color = Colors.primaries[Random().nextInt(Colors.primaries.length)].value;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
