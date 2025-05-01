import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_hmac_service.dart';
import 'package:cryptools/ui/widgets/input_type_selector.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HashController extends GetxController {
  final CryptoHashService _hashService;
  final CryptoHMACService _hmacService;

  final hashResultController = TextEditingController();
  final hmacKeyInputController = TextEditingController();
  final textInputController = TextEditingController();

  final _isAutoHash = true.obs;
  bool get isAutoHash => _isAutoHash.value;

  final _isHmacMode = false.obs;
  bool get isHmacMode => _isHmacMode.value;

  final _selectedFile = Rx<XFile?>(null);
  XFile? get selectedFile => _selectedFile.value;

  final _selectedHashAlgorithm = HashAlgorithms.md5.obs;
  HashAlgorithms get selectedHashAlgorithm => _selectedHashAlgorithm.value;

  final _selectedInputType = InputType.text.obs;
  InputType get selectedInputType => _selectedInputType.value;

  HashController({
    required CryptoHashService hashService,
    required CryptoHMACService hmacService,
  }) : _hashService = hashService,
       _hmacService = hmacService;

  @override
  void onInit() {
    super.onInit();
    textInputController.addListener(() {
      _processHashAuto();
    });
    hmacKeyInputController.addListener(() {
      _processHashAuto();
    });
  }

  @override
  void onClose() {
    hashResultController.dispose();
    hmacKeyInputController.dispose();
    textInputController.dispose();

    super.onClose();
  }

  void _hashFile() async {
    final file = selectedFile;
    final hmacKey = hmacKeyInputController.text;

    hashResultController.text = '';

    try {
      if (file != null) {
        if (isHmacMode && hmacKey.isNotEmpty) {
          hashResultController.text = await _hmacService.hmacFile(
            algorithm: selectedHashAlgorithm,
            key: utf8.encode(hmacKey),
            file: file,
          );
        } else if (!isHmacMode) {
          hashResultController.text = await _hashService.hashFile(
            algorithm: selectedHashAlgorithm,
            file: file,
          );
        }
      }
    } catch (e) {}
  }

  void _hashText() {
    final text = textInputController.text;
    final hmacKey = hmacKeyInputController.text;

    try {
      if (text.isNotEmpty && isHmacMode && hmacKey.isNotEmpty) {
        hashResultController.text = _hmacService.hmacBytes(
          algorithm: selectedHashAlgorithm,
          key: utf8.encode(hmacKey),
          bytes: utf8.encode(text),
        );
      } else if (text.isNotEmpty && !isHmacMode) {
        hashResultController.text = _hashService.hashBytes(
          algorithm: selectedHashAlgorithm,
          bytes: utf8.encode(text),
        );
      } else {
        hashResultController.text = '';
      }
    } catch (e) {
      hashResultController.text = 'Hashing error';
    }
  }

  void _processHashAuto() {
    if (isAutoHash && selectedInputType != InputType.file) {
      processHash();
    }
  }

  void clearForm() {
    _selectedFile.value = null;
    textInputController.clear();
    hmacKeyInputController.clear();
    hashResultController.clear();
  }

  void processHash() {
    switch (_selectedInputType.value) {
      case InputType.text:
        _hashText();
      case InputType.file:
        _hashFile();
    }
  }

  void setAutoHash(bool value) {
    _isAutoHash.value = value;
    _processHashAuto();
  }

  void setHmacMode(bool value) {
    _isHmacMode.value = value;
    _processHashAuto();
  }

  void setSelectedFile(XFile? file) {
    _selectedFile.value = file;
  }

  void setSelectedHashAlgorithm(HashAlgorithms algorithm) {
    _selectedHashAlgorithm.value = algorithm;
    _processHashAuto();
  }

  void setSelectedInputType(InputType inputType) {
    _selectedInputType.value = inputType;
    clearForm();
  }
}
