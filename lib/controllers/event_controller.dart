 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/event_form_state.dart';
 import 'package:timelive/models/tag.dart';

class EventController {
  static final CollectionReference _eventsRef = FirebaseFirestore.instance.collection('events');
  static final CollectionReference _tagsRef = FirebaseFirestore.instance.collection('tags');
  

  Future<void> addEvent(EventFormState formState) {
    var event = Event(null, formState.name, formState.description, formState.date, formState.tags);
    
    formState.tags.forEach((tag) {
      var incr_tag = Tag(tag.id, tag.name, tag.counter + 1, tag.color);
      if (tag.counter > 1) { //tag exists, increase counter
        _tagsRef
            .where('id', isEqualTo: tag.id)
            .get()
            .then((QuerySnapshot value) {
              value.docs.forEach((doc) {
                  _tagsRef.doc(doc.id).update(incr_tag.toJson())
                    .then((value) => print('Tag updated'))
                    .catchError((error) => print('Failed to update tag -- $error'));
              });
            });
      } else { //insert new tag
        _tagsRef.add(incr_tag.toJson())
            .then((value) => print('Tag inserted'))
            .catchError((error) => print('Failed to insert tag -- $error'));
      }
    });

    // TODO save files

    return _eventsRef.add(event.toJson())
       .then((value) => print('Event inserted'))
       .catchError((error) => print('Failed to insert event -- $error'));
  }
}