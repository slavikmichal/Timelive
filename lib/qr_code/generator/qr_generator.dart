import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/qr_code_data.dart';

/// The example application class
class QrCodeFactory {

  static const Color vismaBlack = Color(0xff191919);

  static QrImage generateSimple({required String eventId, required double size}) {
    return QrImage(
      data: QrCodeData(eventId, DateTime.now()).toJson().toString(),
      size: size,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      version: QrVersions.auto,
      gapless: false,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: vismaBlack,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: vismaBlack,
      ),
    );
  }

}

