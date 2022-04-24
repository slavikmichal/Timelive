import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/models/event_form_state.dart';
import 'package:timelive/models/tag.dart';
import 'package:timelive/models/timeline_zoom.dart';

import '../models/event.dart';

class EventsCubit extends Cubit<List<Event>> {
  late List<Event> events;

  EventsCubit() : super([]);

  void refreshEvents(List<Tag> activeTags) async {
    events = await EventController.getAllEvents(activeTags);
    emit(events);
  }

  void filterEvents(TimelineZoom zoom) {
    switch (zoom) {
      case TimelineZoom.year:
        {
          emit(events.map((e) => e.date.year).toSet().map((e) => Event('', '', '', DateTime(e), const [])).toList());
          break;
        }
      case TimelineZoom.month:
        {
          emit(events
              .map((e) => _formatDateTime(e.date).substring(3))
              .toSet()
              .map(
                  (e) => Event('', '', '', DateTime(int.parse(e.substring(3)), int.parse(e.substring(0, 2))), const []))
              .toList());
          break;
        }
      case TimelineZoom.day:
        {
          emit(events.map((e) => e.date).toSet().map((e) => Event('', '', '', DateTime(e.year, e.month, e.day), const [])).toList());
          break;
        }
      case TimelineZoom.shortDescription:
        {
          emit(events);
          break;
        }
      case TimelineZoom.fullDescription:
        {
          emit(events);
          break;
        }
    }
  }

  String _formatDateTime(DateTime date) {
    var day = date.day.toString().padLeft(2, '0');
    var month = date.month.toString().padLeft(2, '0');
    var year = date.year.toString();
    return "$day.$month.$year";
  }

  Event getEventById(String id) {
    return events.firstWhere((element) => element.id == id);
  }

  int getIndexById(String id) {
    return events.indexWhere((element) => element.id == id);
  }
}
