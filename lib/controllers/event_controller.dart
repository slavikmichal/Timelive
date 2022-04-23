import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/event_form_state.dart';
import 'package:timelive/models/tag.dart';

class EventController {
  static final CollectionReference<Event> _eventsRef =
      FirebaseFirestore.instance.collection('events').withConverter<Event>(
          fromFirestore: (snapshot, _) =>
              Event.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (event, _) => event.toJson());
  static final CollectionReference<Tag> _tagsRef = FirebaseFirestore.instance
      .collection('tags')
      .withConverter<Tag>(
          fromFirestore: (snapshot, _) => Tag.fromJson(snapshot.data()!),
          toFirestore: (tag, _) => tag.toJson());

  static Stream<QuerySnapshot<Event>> getEventsStream() {
    return _eventsRef.snapshots();
  }

  static Future<void> addEvent(EventFormState formState) {
    var event = Event(null, formState.name, formState.description,
        formState.date, formState.tags);

    formState.tags.forEach((tag) {
      var incrTag = Tag(tag.id, tag.name, tag.counter + 1, tag.color);
      if (tag.counter > 1) {
        //tag exists, increase counter
        _tagsRef
            .where('id', isEqualTo: tag.id)
            .get()
            .then((QuerySnapshot value) {
          value.docs.forEach((doc) {
            _tagsRef
                .doc(doc.id)
                .update(incrTag.toJson())
                .then((value) => print('Tag updated'))
                .catchError((error) => print('Failed to update tag -- $error'));
          });
        });
      } else {
        //insert new tag
        _tagsRef
            .add(incrTag)
            .then((value) => print('Tag inserted'))
            .catchError((error) => print('Failed to insert tag -- $error'));
      }
    });

    // TODO save files

    return _eventsRef
        .add(event)
        .then((value) => print('Event inserted'))
        .catchError((error) => print('Failed to insert event -- $error'));
  }
}
