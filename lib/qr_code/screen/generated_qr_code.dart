import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:timelive/models/event.dart';
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../themes/color_schemer.dart';
import '../generator/qr_generator.dart';

class GeneratedQrCodeScreen extends StatelessWidget {
  static double qrCodeSize = 280.0;

  final Event event;

  GeneratedQrCodeScreen({required this.event, Key? key}) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();

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
              child: InkWell(
                onLongPress: () =>
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: ElevatedButton(
                                onPressed: () => saveQr(),
                                child: Text("Save image")),
                          );
                        }),
                child: Screenshot(
                  controller: screenshotController,
                  child: QrCodeFactory.generateSimple(eventId: event.id!, size: qrCodeSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveQr() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          final String fullPath = '$directory/${DateTime.now().millisecond}.png';
          File capturedFile = File(fullPath);
          await capturedFile.writeAsBytes(image);
          print(capturedFile.path);
          await GallerySaver.saveImage(capturedFile.path).then((value) {
            print('PRINTED');
          });
        } catch (error) {}
      }
    }
    );
  }
}
