import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';

/// The example application class
class QrScanner {

  static Future<ScanResult> startScanning() async {
    try {
      return await BarcodeScanner.scan(
        options: const ScanOptions(
          restrictFormat: [BarcodeFormat.qr],
        ),
      );
    } on PlatformException catch (e) {
      return ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
        rawContent: e.code == BarcodeScanner.cameraAccessDenied
            ? 'The user did not grant the camera permission!'
            : 'Unknown error: $e',
      );
    }
  }
}
