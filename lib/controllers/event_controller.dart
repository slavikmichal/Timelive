import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/event_form_state.dart';
import 'package:timelive/models/tag.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class EventController {
  static final CollectionReference<Event> _eventsRef = FirebaseFirestore.instance
      .collection('events')
      .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (event, _) => event.toJson());
  static final CollectionReference<Tag> _tagsRef = FirebaseFirestore.instance.collection('tags').withConverter<Tag>(
      fromFirestore: (snapshot, _) => Tag.fromJson(snapshot.data()!), toFirestore: (tag, _) => tag.toJson());
  static final storageRef = FirebaseStorage.instance.ref();

  static Stream<QuerySnapshot<Event>> getEventsStream(List<String> filters) {
    return filters.isEmpty ? _eventsRef.snapshots() : _eventsRef.where("tags", arrayContainsAny: filters).snapshots();
  }

  static Stream<QuerySnapshot<Tag>> getTagsStream() {
    return _tagsRef.snapshots();
  }

  static Future<void> addEvent(EventFormState formState) {
    var event = Event(null, formState.name, formState.description, formState.date, formState.tags);

    formState.tags.forEach((tag) {
      _tagsRef.where('name', isEqualTo: tag).get().then((value) {
        if (value.docs.isEmpty) {
          _tagsRef
              .add(Tag.id(tag))
              .then((value) => print('Tag inserted'))
              .catchError((error) => print('Failed to insert tag -- $error'));
        } else {
          Tag editingTag = value.docs.first.data();
          _tagsRef
              .doc(value.docs.first.id)
              .update(Tag(editingTag.name, editingTag.counter + 1, editingTag.color).toJson())
              .then((value) => print('Tag updated'))
              .catchError((error) => print('Failed to update tag -- $error'));
        }
      });
    });

    return _eventsRef
        .add(event)
        .then((value) => _saveFiles(value.id, formState.images))
        .catchError((error) => print('Failed to insert event -- $error'));
  }

  static Future _saveFiles(String eventId, List<File> files) async {
    files.forEach((file) async {
      final fileName = basename(file.path);
      final destination = '$eventId/$fileName';

      try {
        final ref = storageRef.storage.ref(destination);
        await ref.putFile(file);
      } catch (e) {
        print('error occured while saving file');
      }
    });
  }
}
