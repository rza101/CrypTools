import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EncodeController extends GetxController {
  final CryptoEncodeService _encodeService;

  final firstInputTextController = TextEditingController();
  final secondInputTextController = TextEditingController();

  final _firstEncodingType = EncodingTypes.utf8.obs;
  EncodingTypes get firstEncodingType => _firstEncodingType.value;

  final _secondEncodingType = EncodingTypes.utf8.obs;
  EncodingTypes get secondEncodingType => _secondEncodingType.value;

  EncodeController({required CryptoEncodeService encodeService})
    : _encodeService = encodeService;

  void processFirstInput() {
    try {
      secondInputTextController.text = _encodeService.convertToEncoding(
        _encodeService.convertToByteArray(
          firstInputTextController.text,
          firstEncodingType,
        ),
        secondEncodingType,
      );
    } catch (e) {
      secondInputTextController.text = 'Invalid first input';
    }
  }

  void processSecondInput() {
    try {
      firstInputTextController.text = _encodeService.convertToEncoding(
        _encodeService.convertToByteArray(
          secondInputTextController.text,
          secondEncodingType,
        ),
        firstEncodingType,
      );
    } catch (e) {
      firstInputTextController.text = 'Invalid second input';
    }
  }

  void setFirstEncodingType(EncodingTypes encoding) {
    _firstEncodingType.value = encoding;
    processSecondInput();
  }

  void setSecondEncodingType(EncodingTypes encoding) {
    _secondEncodingType.value = encoding;
    processFirstInput();
  }
}
