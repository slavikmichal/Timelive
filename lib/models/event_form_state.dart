import 'dart:io';

class EventFormState {
  String name = '';
  String description = '';
  DateTime date = DateTime.now();
  List<File> images = [];
  List<String> tags = [];

  EventFormState();
}
