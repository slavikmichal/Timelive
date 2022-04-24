import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelive/models/event.dart';

import '../../themes/color_schemer.dart';
import '../generator/qr_generator.dart';

class GeneratedQrCodeScreen extends StatelessWidget {
  static double qrCodeSize = 280.0;

  final Event event;

  const GeneratedQrCodeScreen({required this.event, Key? key}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  event.name,
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow,
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: ColorSchemer.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(event.id!),
            Center(
              child: QrCodeFactory.generateSimple(eventId: event.id!, size: qrCodeSize),
            ),
          ],
        ),
      ),
    );
  }
}
