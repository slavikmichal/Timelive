 import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/event_form_state.dart';
 import 'package:timelive/models/tag.dart';
 import 'package:firebase_storage/firebase_storage.dart';
 import 'package:path/path.dart';

class EventController {
  static final CollectionReference _eventsRef = FirebaseFirestore.instance.collection('events');
  static final CollectionReference _tagsRef = FirebaseFirestore.instance.collection('tags');
  static final storageRef = FirebaseStorage.instance.ref();

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

    return _eventsRef.add(event.toJson())
       .then((value) => _saveFiles(value.id, formState.images))
       .catchError((error) => print('Failed to insert event -- $error'));
  }

  Future _saveFiles(String event_id, List<File> files) async {
    files.forEach((file) async {
      final fileName = basename(file!.path);
      final destination = '$event_id/$fileName';

      try {
        final ref = storageRef.storage.ref(destination);
        await ref.putFile(file);
      } catch (e) {
        print('error occured while saving file');
      }
    });
  }
}