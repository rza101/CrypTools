import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/core/crypto/crypto_encrypt_service.dart';
import 'package:cryptools/core/crypto/crypto_random_service.dart';
import 'package:cryptools/core/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EncryptController extends GetxController {
  final CryptoRandomService _randomService;
  final CryptoEncryptService _encryptService;

  final keyTextController = TextEditingController();
  final nonceTextController = TextEditingController();
  final plaintextTextController = TextEditingController();
  final ciphertextTextController = TextEditingController();

  final keyFormKey = GlobalKey<FormFieldState>();
  final nonceFormKey = GlobalKey<FormFieldState>();
  final plaintextFormKey = GlobalKey<FormFieldState>();
  final ciphertextFormKey = GlobalKey<FormFieldState>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  EncryptController({
    required CryptoRandomService randomService,
    required CryptoEncryptService encryptService,
  }) : _randomService = randomService,
       _encryptService = encryptService;

  @override
  void onInit() {
    super.onInit();
    generateKey();
    generateNonce();
  }

  void aesEncrypt() {
    if (keyFormKey.currentState?.validate() != true ||
        nonceFormKey.currentState?.validate() != true ||
        plaintextFormKey.currentState?.validate() != true) {
      return;
    }

    try {
      _isLoading.value = true;

      final Uint8List key = base64.decode(keyTextController.text);
      final Uint8List nonce = base64.decode(nonceTextController.text);
      final Uint8List plaintext = utf8.encode(plaintextTextController.text);

      ciphertextTextController.text = base64.encode(
        _encryptService.aesEncrypt(
          key: key,
          nonce: nonce,
          plaintext: plaintext,
        ),
      );
      ciphertextFormKey.currentState?.validate();
    } catch (e) {
      ciphertextTextController.text = 'Encryption failed';
    } finally {
      _isLoading.value = false;
    }
  }

  void aesDecrypt() {
    if (keyFormKey.currentState?.validate() != true ||
        nonceFormKey.currentState?.validate() != true ||
        ciphertextFormKey.currentState?.validate() != true) {
      return;
    }

    try {
      _isLoading.value = true;

      final Uint8List key = base64.decode(keyTextController.text);
      final Uint8List nonce = base64.decode(nonceTextController.text);
      final Uint8List ciphertext = base64.decode(ciphertextTextController.text);

      plaintextTextController.text = utf8.decode(
        _encryptService.aesDecrypt(
          key: key,
          nonce: nonce,
          ciphertext: ciphertext,
        ),
      );
      plaintextFormKey.currentState?.validate();
    } catch (e) {
      plaintextTextController.text = 'Decryption failed';
    } finally {
      _isLoading.value = false;
    }
  }

  void generateKey() {
    keyTextController.text = base64.encode(
      _randomService.generateRandomBytes(32),
    );
  }

  void generateNonce() {
    nonceTextController.text = base64.encode(
      _randomService.generateRandomBytes(12),
    );
  }

  String? validateKey(String? value) {
    if (value == null || value.isEmpty) {
      return 'Key cannot be empty';
    }

    if (!validateEncoding(value, EncodingTypes.base64)) {
      return 'Key must be in Base64';
    }

    if (![16, 24, 32].contains(base64.decode(value).length)) {
      return 'Key length must be 128, 192, or 256 bits';
    }

    return null;
  }

  String? validateNonce(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nonce cannot be empty';
    }

    if (!validateEncoding(value, EncodingTypes.base64)) {
      return 'Nonce must be in Base64';
    }

    if (base64.decode(value).length != 12) {
      return 'Nonce length must be 192 bits';
    }

    return null;
  }

  String? validatePlaintext(String? value) {
    if (value == null || value.isEmpty) {
      return 'Plaintext cannot be empty';
    }

    return null;
  }

  String? validateCiphertext(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ciphertext cannot be empty';
    }

    if (!validateEncoding(value, EncodingTypes.base64)) {
      return 'Ciphertext must be in Base64';
    }

    return null;
  }
}
