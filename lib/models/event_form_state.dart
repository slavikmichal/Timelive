import 'dart:io';

import 'package:timelive/models/tag.dart';

class EventFormState {
  String name = '';
  String description = '';
  DateTime date = DateTime.now();
  List<File> images = [];
  List<Tag> tags = [];

  EventFormState();
}
