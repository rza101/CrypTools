import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/core/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EncodeController extends GetxController {
  final CryptoEncodeService _encodeService;

  final firstInputTextController = TextEditingController();
  final secondInputTextController = TextEditingController();

  final firstInputFormKey = GlobalKey<FormFieldState>();
  final secondInputFormKey = GlobalKey<FormFieldState>();

  final _firstEncodingType = EncodingTypes.utf8.obs;
  EncodingTypes get firstEncodingType => _firstEncodingType.value;

  final _secondEncodingType = EncodingTypes.utf8.obs;
  EncodingTypes get secondEncodingType => _secondEncodingType.value;

  EncodeController({required CryptoEncodeService encodeService})
    : _encodeService = encodeService;

  void processFirstInput() {
    try {
      if (firstInputFormKey.currentState?.validate() != true) {
        return;
      }

      secondInputTextController.text = _encodeService.convertToEncoding(
        _encodeService.convertToByteArray(
          firstInputTextController.text,
          firstEncodingType,
        ),
        secondEncodingType,
      );
    } catch (_) {}
  }

  void processSecondInput() {
    try {
      if (secondInputFormKey.currentState?.validate() != true) {
        return;
      }

      firstInputTextController.text = _encodeService.convertToEncoding(
        _encodeService.convertToByteArray(
          secondInputTextController.text,
          secondEncodingType,
        ),
        firstEncodingType,
      );
    } catch (_) {}
  }

  void setFirstEncodingType(EncodingTypes encoding) {
    _firstEncodingType.value = encoding;
    processSecondInput();
  }

  void setSecondEncodingType(EncodingTypes encoding) {
    _secondEncodingType.value = encoding;
    processFirstInput();
  }

  String? _validateInput(String value, EncodingTypes encoding) {
    switch (encoding) {
      case EncodingTypes.utf8 || EncodingTypes.ascii:
        return null;
      case EncodingTypes.base64:
        if (!validateEncoding(value, EncodingTypes.base64)) {
          return 'Value must be in Base64';
        }
      case EncodingTypes.base64Url:
        if (!validateEncoding(value, EncodingTypes.base64Url)) {
          return 'Value must be in Base64 (URL safe)';
        }
      case EncodingTypes.hex:
        if (!validateEncoding(value, EncodingTypes.hex)) {
          return 'Value must be in hexadecimal';
        }
    }

    return null;
  }

  String? validateFirstInput(String? value) {
    if (value != null) {
      return _validateInput(value, firstEncodingType);
    }

    return null;
  }

  String? validateSecondInput(String? value) {
    if (value != null) {
      return _validateInput(value, secondEncodingType);
    }

    return null; // allow empty
  }
}
