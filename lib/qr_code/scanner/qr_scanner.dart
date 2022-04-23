import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:timelive/qr_code/model/qr_code_data.dart';

/// The example application class
class QrScanner {
  static Future<ScanResult> _startScanning() async {
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

  static Future<QrCodeData?> scan() async {
    var scanResult = await QrScanner._startScanning();

    if (scanResult.type == ResultType.Barcode) {
      var json = jsonDecode(scanResult.rawContent);
      var qrCode = QrCodeData.fromJson(json);

      return qrCode;
    }

    // cancelled / error during scan
    return null;
  }
}
