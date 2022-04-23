import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Tag {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'counter')
  final int counter;


  Tag(this.name, this.counter);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}