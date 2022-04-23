import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../generator/qr_generator.dart';

class GeneratedQrCodeScreen extends StatelessWidget {
  static double qrCodeSize = 240.0;

  final String eventId;

  const GeneratedQrCodeScreen({required this.eventId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_before),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: QrCodeFactory.generateSimple(eventId: eventId, size: qrCodeSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40).copyWith(bottom: 40),
              child: Text('Generated QR Code with eventId = $eventId'),
            ),
          ],
        ),
      ),
    );
  }
}
