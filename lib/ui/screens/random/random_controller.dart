import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/core/crypto/crypto_random_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RandomController extends GetxController {
  final CryptoEncodeService _encodeService;
  final CryptoRandomService _randomService;

  final byteLengthTextController = TextEditingController();
  final outputTextController = TextEditingController();

  final _encodingType = EncodingTypes.ascii.obs;

  var _randomBytes = Uint8List(0);

  RandomController({
    required CryptoEncodeService encodeService,
    required CryptoRandomService randomService,
  }) : _encodeService = encodeService,
       _randomService = randomService;

  @override
  void onInit() {
    super.onInit();
    byteLengthTextController.text = '10';
  }

  void formatRandomValue() {
    try {
      outputTextController.text = switch (_encodingType.value) {
        EncodingTypes.ascii || EncodingTypes.utf8 => _encodeService
            .convertToEncoding(EncodingTypes.hex, _randomBytes),

        _ => _encodeService.convertToEncoding(
          _encodingType.value,
          _randomBytes,
        ),
      };
    } catch (e) {
      outputTextController.text = 'Failed to format random value';
    }
  }

  void generateRandomValue() {
    try {
      _randomBytes = _randomService.generateRandomBytes(
        int.tryParse(byteLengthTextController.text) ?? 0,
      );
      formatRandomValue();
    } catch (e) {
      outputTextController.text = 'Failed to generate random value';
    }
  }

  void setEncodingType(EncodingTypes encoding) {
    _encodingType.value = encoding;
    formatRandomValue();
  }
}
