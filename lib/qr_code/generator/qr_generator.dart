import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// The example application class
class QrCodeFactory {

  static const Color vismaBlack = Color(0xff191919);

  static QrImage generateSimple(String message, double size) {
    return QrImage(
      data: message,
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

