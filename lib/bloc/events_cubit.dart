import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/models/event_form_state.dart';

import '../models/event.dart';

class EventsCubit extends Cubit<List<Event>> {
  late final List<Event> events;

  EventsCubit() : super([]);

  void refreshEvents() async {
    events = await EventController.getAllEvents();
    emit(events);
  }

  void addEvent(EventFormState eventFormState) {
    EventController.addEvent(eventFormState);
    refreshEvents();
  }

  Event getEventById(String id) {
    return events.firstWhere((element) => element.id == id);
  }

  int getIndexById(String id) {
    return events.indexWhere((element) => element.id == id);
  }
}
