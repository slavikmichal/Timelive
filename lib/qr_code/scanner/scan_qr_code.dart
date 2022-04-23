import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:timelive/qr_code/scanner/qr_scanner.dart';

void main() => runApp(const ScanQrExample());

class ScanQrExample extends StatefulWidget {
  const ScanQrExample({Key? key}) : super(key: key);

  @override
  _ScanQrExampleState createState() => _ScanQrExampleState();
}

class _ScanQrExampleState extends State<ScanQrExample> {
  ScanResult? scanResult;

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
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
            if (scanResult == null) Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Scan QR Code'),
              ],
            ),
            if (scanResult != null)
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Result Type'),
                      subtitle: Text(scanResult.type.toString()),
                    ),
                    ListTile(
                      title: const Text('Raw Content'),
                      subtitle: Text(scanResult.rawContent),
                    ),
                    ListTile(
                      title: const Text('Format'),
                      subtitle: Text(scanResult.format.toString()),
                    ),
                    ListTile(
                      title: const Text('Format note'),
                      subtitle: Text(scanResult.formatNote),
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
    var result = await QrScanner.startScanning();
    setState(() => scanResult = result);
  }
}
