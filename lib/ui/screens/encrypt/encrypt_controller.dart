import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_encrypt_service.dart';
import 'package:cryptools/core/crypto/crypto_random_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EncryptController extends GetxController {
  final CryptoRandomService _randomService;
  final CryptoEncryptService _encryptService;

  final keyInputController = TextEditingController();
  final nonceInputController = TextEditingController();
  final ciphertextController = TextEditingController();
  final plaintextController = TextEditingController();

  EncryptController({
    required CryptoRandomService randomService,
    required CryptoEncryptService encryptService,
  }) : _randomService = randomService,
       _encryptService = encryptService;

  @override
  void onInit() {
    super.onInit();
    generateRandomKey();
    generateNonce();
  }

  void aesEncrypt() {
    late Uint8List key;
    late Uint8List nonce;

    try {
      key = Base64Decoder().convert(keyInputController.text);
      assert([128, 192, 256].contains(key.length * 8));
    } catch (e) {
      ciphertextController.text =
          'Key must be in Base64 with 128, 192, or 256 bits length';
      return;
    }

    try {
      nonce = Base64Decoder().convert(nonceInputController.text);
      assert(nonce.length * 8 == 96);
    } catch (e) {
      ciphertextController.text = 'Nonce must be in Base64 with 96 bits length';
      return;
    }

    try {
      ciphertextController.text = Base64Encoder().convert(
        _encryptService.aesEncrypt(
          key: key,
          nonce: nonce,
          plaintext: utf8.encode(plaintextController.text),
        ),
      );
    } catch (e) {
      ciphertextController.text = 'Encryption failed';
    }
  }

  void aesDecrypt() {
    late Uint8List key;
    late Uint8List nonce;

    try {
      key = Base64Decoder().convert(keyInputController.text);
      assert([128, 192, 256].contains(key.length * 8));
    } catch (e) {
      plaintextController.text =
          'Key must be in Base64 with 128, 192, or 256 bits length';
      return;
    }

    try {
      nonce = Base64Decoder().convert(nonceInputController.text);
      assert(nonce.length * 8 == 96);
    } catch (e) {
      plaintextController.text = 'Nonce must be in Base64 with 96 bits length';
      return;
    }

    try {
      plaintextController.text = utf8.decode(
        _encryptService.aesDecrypt(
          key: key,
          nonce: nonce,
          ciphertext: Base64Decoder().convert(ciphertextController.text),
        ),
      );
    } catch (e) {
      plaintextController.text = 'Decryption failed';
    }
  }

  void generateNonce() {
    nonceInputController.text = Base64Encoder().convert(
      _randomService.generateRandomBytes(12),
    );
  }

  void generateRandomKey() {
    keyInputController.text = Base64Encoder().convert(
      _randomService.generateRandomBytes(32),
    );
  }
}
