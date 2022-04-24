import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/models/tag.dart';
import 'package:timelive/models/timeline_zoom.dart';

import '../models/event.dart';
import '../models/event_form_state.dart';

class EventsCubit extends Cubit<List<Event>> {
  late List<Event> events = [];
  late List<Tag> cachedTags = [];

  EventsCubit() : super([]);

  void refreshEvents(List<Tag> activeTags) async {
    events = await EventController.getAllEvents(activeTags);
    cachedTags = activeTags;
    emit(events);
  }

  void addEvent(EventFormState eventFormState) {
    EventController.addEvent(eventFormState);
    refreshEvents(cachedTags);
  }

  void filterEvents(List<Tag> activeTags, TimelineZoom zoom) {
    switch (zoom) {
      case TimelineZoom.year:
        {
          final eventsCopy = events;
          emit(eventsCopy.map((e) => e.date.year).toSet().map((e) => Event('', '', '', DateTime(e), const [])).toList());
          break;
        }
      case TimelineZoom.month:
        {
          final eventsCopy = events;
          emit(eventsCopy
              .map((e) => _formatDateTime(e.date).substring(3))
              .toSet()
              .map(
                  (e) => Event('', '', '', DateTime(int.parse(e.substring(3)), int.parse(e.substring(0, 2))), const []))
              .toList());
          break;
        }
      case TimelineZoom.day:
        {
          refreshEvents(activeTags);
          break;
        }
      case TimelineZoom.shortDescription:
        {
          refreshEvents(activeTags);
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
