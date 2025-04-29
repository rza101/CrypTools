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

  final RxBool isAutoHash = true.obs;
  final RxBool isHmacMode = false.obs;
  final Rx<XFile?> selectedFile = Rx<XFile?>(null);
  final Rx<HashAlgorithms> selectedHashAlgorithm = HashAlgorithms.md5.obs;
  final Rx<InputType> selectedInputType = InputType.text.obs;

  // bool get isAutoHash => _isAutoHash.value;
  // bool get isHmacMode => _isHmacMode.value;
  // XFile? get selectedFile => _selectedFile.value;
  // HashAlgorithms get selectedHashAlgorithm => _selectedHashAlgorithm.value;
  // InputType get selectedInputType => _selectedInputType.value;

  HashController({required this.hashService, required this.hmacService});

  @override
  void onInit() {
    super.onInit();

    ever(isAutoHash, (value) => {});
  }

  @override
  void onClose() {
    hashResultController.dispose();
    hmacKeyInputController.dispose();
    textInputController.dispose();

    super.onClose();
  }

  void clearForm() {
    selectedFile.value = null;
    textInputController.clear();
    hmacKeyInputController.clear();
    hashResultController.clear();
  }

  void doAutoHashing() {
    if (isAutoHash.value && selectedInputType.value != InputType.file) {
      doHashing();
    }
  }

  void doHashing() {
    switch (selectedInputType.value) {
      case InputType.text:
        hashPlaintext();
      case InputType.file:
        hashFile();
    }
  }

  void hashPlaintext() {
    final text = textInputController.text;
    final hmacKey = hmacKeyInputController.text;

    if (text.isNotEmpty && isHmacMode.value && hmacKey.isNotEmpty) {
      hashResultController.text = hmacService.hmacBytes(
        algorithm: selectedHashAlgorithm.value,
        key: utf8.encode(hmacKey),
        input: utf8.encode(text),
      );
    } else if (text.isNotEmpty && !isHmacMode.value) {
      hashResultController.text = hashService.hashBytes(
        algorithm: selectedHashAlgorithm.value,
        input: utf8.encode(text),
      );
    } else {
      hashResultController.text = '';
    }
  }

  void hashFile() async {
    final file = selectedFile.value;
    final hmacKey = hmacKeyInputController.text;

    hashResultController.text = '';

    if (file != null) {
      if (isHmacMode.value && hmacKey.isNotEmpty) {
        hashResultController.text = await hmacService.hmacFile(
          algorithm: selectedHashAlgorithm.value,
          key: utf8.encode(hmacKey),
          file: file,
        );
      } else if (!isHmacMode.value) {
        hashResultController.text = await hashService.hashFile(
          algorithm: selectedHashAlgorithm.value,
          file: file,
        );
      }
    }
  }
}
