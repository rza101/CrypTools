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

  final keyLengthFormKey = GlobalKey<FormFieldState>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

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
    try {
      if (keyLengthFormKey.currentState?.validate() != true) {
        return;
      }

      _isLoading.value = true;

      final keyLength = int.parse(rsaKeyLengthInputController.text);
      final keyPair = await _keygenService.generateRSAKeyPair(
        keyLength,
        _randomService.generateFortunaRandomInstance(),
      );

      publicKeyOutputController.text = keyPair.publicKey.toPEM();
      privateKeyOutputController.text = keyPair.privateKey.toPEM();
    } catch (e) {
      publicKeyOutputController.text = 'Key generation failed';
      privateKeyOutputController.text = 'Key generation failed';
    } finally {
      _isLoading.value = false;
    }
  }

  String? validateKeyLength(String? value) {
    if (value == null || value.isEmpty) {
      return 'Key length cannot be empty';
    }

    if (!value.isNumericOnly) {
      return 'Key length must be a number';
    }

    if (int.parse(value) < 512) {
      return 'Key length must be bigger than 512';
    }

    return null;
  }
}
