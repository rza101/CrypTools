import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_hmac_service.dart';
import 'package:cryptools/ui/widgets/input_type_selector.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HashController extends GetxController {
  final CryptoHashService hashService;
  final CryptoHMACService hmacService;

  final TextEditingController hashResultController = TextEditingController();
  final TextEditingController hmacKeyInputController = TextEditingController();
  final TextEditingController textInputController = TextEditingController();

  final RxBool _isAutoHash = true.obs;
  final RxBool _isHmacMode = false.obs;
  final Rx<XFile?> _selectedFile = Rx<XFile?>(null);
  final Rx<HashAlgorithms> _selectedHashAlgorithm = HashAlgorithms.md5.obs;
  final Rx<InputType> _selectedInputType = InputType.text.obs;

  bool get isAutoHash => _isAutoHash.value;
  bool get isHmacMode => _isHmacMode.value;
  XFile? get selectedFile => _selectedFile.value;
  HashAlgorithms get selectedHashAlgorithm => _selectedHashAlgorithm.value;
  InputType get selectedInputType => _selectedInputType.value;

  HashController({required this.hashService, required this.hmacService});

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

    if (file != null) {
      if (isHmacMode && hmacKey.isNotEmpty) {
        hashResultController.text = await hmacService.hmacFile(
          algorithm: selectedHashAlgorithm,
          key: utf8.encode(hmacKey),
          file: file,
        );
      } else if (!isHmacMode) {
        hashResultController.text = await hashService.hashFile(
          algorithm: selectedHashAlgorithm,
          file: file,
        );
      }
    }
  }

  void _hashText() {
    final text = textInputController.text;
    final hmacKey = hmacKeyInputController.text;

    if (text.isNotEmpty && isHmacMode && hmacKey.isNotEmpty) {
      hashResultController.text = hmacService.hmacBytes(
        algorithm: selectedHashAlgorithm,
        key: utf8.encode(hmacKey),
        bytes: utf8.encode(text),
      );
    } else if (text.isNotEmpty && !isHmacMode) {
      hashResultController.text = hashService.hashBytes(
        algorithm: selectedHashAlgorithm,
        bytes: utf8.encode(text),
      );
    } else {
      hashResultController.text = '';
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
