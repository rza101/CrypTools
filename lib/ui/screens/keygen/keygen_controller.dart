import 'package:cryptools/core/crypto/crypto_keygen_service.dart';
import 'package:cryptools/core/crypto/crypto_random_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class KeygenController extends GetxController {
  final CryptoKeygenService _keygenService;
  final CryptoRandomService _randomService;

  final rsaKeyLengthInputController = TextEditingController();
  final publicKeyOutputController = TextEditingController();
  final privateKeyOutputController = TextEditingController();

  KeygenController({
    required CryptoKeygenService keygenService,
    required CryptoRandomService randomService,
  }) : _keygenService = keygenService,
       _randomService = randomService;

  @override
  void onInit() {
    super.onInit();
    rsaKeyLengthInputController.text = '1024';
  }

  void generateKey() async {
    final keyLength = int.tryParse(rsaKeyLengthInputController.text);

    if (keyLength == null) {
      publicKeyOutputController.text = 'Invalid key length';
      privateKeyOutputController.text = 'Invalid key length';
      return;
    }

    try {
      final keyPair = await _keygenService.generateRSAKeyPair(
        keyLength,
        _randomService.generateFortunaRandomInstance(),
      );

      publicKeyOutputController.text = keyPair.publicKey.toPEM();
      privateKeyOutputController.text = keyPair.privateKey.toPEM();
    } catch (e) {
      publicKeyOutputController.text = 'Key generation failed';
      privateKeyOutputController.text = 'Key generation failed';
    }
  }
}
