import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timelive/qr_code/generator/qr_generator.dart';

void main() => runApp(GenerateQrExample());

/// The example application class
class GenerateQrExample extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'QR.Flutter',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: GenerateQrCode(),
    );
  }
}

/// This is the screen that you'll see when the app starts
class GenerateQrCode extends StatefulWidget {
  @override
  _GenerateQrCodeState createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  @override
  Widget build(BuildContext context) {
    const eventId = 'beed03ee-6446-4843-b2c9-d9cdd824736d';
    const size = 360.0;

    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child:
                    QrCodeFactory.generateSimple(eventId: eventId, size: size),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                  .copyWith(bottom: 40),
              child: const Text(eventId),
            ),
          ],
        ),
      ),
    );
  }
}
