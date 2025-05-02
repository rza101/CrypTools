import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EncodeController extends GetxController {
  final CryptoEncodeService _encodeService;

  final firstInputController = TextEditingController();
  final secondInputController = TextEditingController();

  final _firstEncodingType = EncodingTypes.utf8.obs;
  EncodingTypes get firstEncodingType => _firstEncodingType.value;

  final _secondEncodingType = EncodingTypes.utf8.obs;
  EncodingTypes get secondEncodingType => _secondEncodingType.value;

  EncodeController({required CryptoEncodeService encodeService})
    : _encodeService = encodeService;

  void processFirstInput() {
    try {
      secondInputController.text = _encodeService.convertToEncoding(
        secondEncodingType,
        _encodeService.convertToByteArray(
          firstEncodingType,
          firstInputController.text,
        ),
      );
    } catch (e) {
      secondInputController.text = 'Invalid first input';
    }
  }

  void processSecondInput() {
    try {
      firstInputController.text = _encodeService.convertToEncoding(
        firstEncodingType,
        _encodeService.convertToByteArray(
          secondEncodingType,
          secondInputController.text,
        ),
      );
    } catch (e) {
      firstInputController.text = 'Invalid second input';
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
