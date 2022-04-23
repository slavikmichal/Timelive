import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timelive/qr_code/model/qr_code_data.dart';
import 'package:timelive/qr_code/scanner/qr_scanner.dart';

void main() => runApp(const ScanQrExample());

class ScanQrExample extends StatefulWidget {
  const ScanQrExample({Key? key}) : super(key: key);

  @override
  _ScanQrExampleState createState() => _ScanQrExampleState();
}

class _ScanQrExampleState extends State<ScanQrExample> {
  QrCodeData? qrCodeData;

  @override
  Widget build(BuildContext context) {
    final qrCodeData = this.qrCodeData;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Barcode Scanner Example'),
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: 'QR Code scan',
              onPressed: _scan,
            )
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            if (qrCodeData == null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Scan QR Code'),
                ],
              ),
            if (qrCodeData != null)
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Event ID'),
                      subtitle: Text(qrCodeData.eventId),
                    ),
                    ListTile(
                      title: const Text('Qr Generated At:'),
                      subtitle: Text(qrCodeData.created.toString()),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _scan() async {
    var result = await QrScanner.scan();
    setState(() => qrCodeData = result);
  }
}
