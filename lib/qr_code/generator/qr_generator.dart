import 'dart:convert';

import 'package:qr_flutter/qr_flutter.dart';

import '../../themes/color_schemer.dart';
import '../model/qr_code_data.dart';

/// The example application class
class QrCodeFactory {
  static QrImage generateSimple({required String eventId, required double size}) {
    return QrImage(
      data: jsonEncode(QrCodeData(eventId, DateTime.now()).toJson()),
      size: size,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      version: QrVersions.auto,
      gapless: false,
      eyeStyle: QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: ColorSchemer.vismaBlack,
      ),
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: ColorSchemer.vismaBlack,
      ),
    );
  }
}
