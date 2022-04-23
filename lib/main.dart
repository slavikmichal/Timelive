import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/models/event_form_state.dart';
import 'package:timelive/timelive_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCIRFX3FoDpuwiC5UOomeOOLgNW2Bdcr6A",
            authDomain: "timelive-dd430.firebaseapp.com",
            projectId: "timelive-dd430",
            storageBucket: "timelive-dd430.appspot.com",
            messagingSenderId: "67776575253",
            appId: "1:67776575253:web:502e48588e2ba707ee9b1c"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const TimeliveApp());
}
