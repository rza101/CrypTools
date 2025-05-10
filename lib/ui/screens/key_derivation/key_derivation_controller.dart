import 'dart:convert';

import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_key_derivation_service.dart';
import 'package:cryptools/core/crypto/crypto_random_service.dart';
import 'package:cryptools/core/helpers.dart';
import 'package:cryptools/ui/widgets/key_derivation_algorithm_selector.dart';
import 'package:cryptools/ui/widgets/key_derivation_process_type_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class KeyDerivationController extends GetxController {
  final CryptoKeyDerivationService _keyDerivationService;
  final CryptoEncodeService _encodeService;
  final CryptoRandomService _randomService;

  final plaintextInputController = TextEditingController();
  final derivedKeyInputController = TextEditingController();
  final bcryptRoundsInputController = TextEditingController();
  final pbkdf2KeyLengthInputController = TextEditingController();
  final pbkdf2RoundsInputController = TextEditingController();
  final pbkdf2SaltInputController = TextEditingController();
  final scryptBlockSizeInputController = TextEditingController(); // r
  final scryptCostInputController = TextEditingController(); // N
  final scryptKeyLengthInputController = TextEditingController();
  final scryptParallelismInputController = TextEditingController(); // p
  final scryptSaltInputController = TextEditingController();
  final resultController = TextEditingController();

  final plaintextFormKey = GlobalKey<FormFieldState>();
  final derivedKeyFormKey = GlobalKey<FormFieldState>();
  final bcryptRoundsFormKey = GlobalKey<FormFieldState>();
  final pbkdf2KeyLengthFormKey = GlobalKey<FormFieldState>();
  final pbkdf2RoundsFormKey = GlobalKey<FormFieldState>();
  final pbkdf2SaltFormKey = GlobalKey<FormFieldState>();
  final scryptBlockSizeFormKey = GlobalKey<FormFieldState>(); // r
  final scryptCostFormKey = GlobalKey<FormFieldState>(); // N
  final scryptKeyLengthFormKey = GlobalKey<FormFieldState>();
  final scryptParallelismFormKey = GlobalKey<FormFieldState>(); // p
  final scryptSaltFormKey = GlobalKey<FormFieldState>();

  final _pbkdf2HashAlgorithm = HashAlgorithms.sha256.obs;
  HashAlgorithms get pbkdf2HashAlgorithm => _pbkdf2HashAlgorithm.value;

  final _keyDerivationAlgorithm = KeyDerivationAlgorithms.bcrypt.obs;
  KeyDerivationAlgorithms get keyDerivationAlgorithm =>
      _keyDerivationAlgorithm.value;

  final _processType = KeyDerivationProcessType.derive.obs;
  KeyDerivationProcessType get processType => _processType.value;

  KeyDerivationController({
    required CryptoKeyDerivationService keyDerivationService,
    required CryptoEncodeService encodeService,
    required CryptoRandomService randomService,
  }) : _keyDerivationService = keyDerivationService,
       _encodeService = encodeService,
       _randomService = randomService;

  @override
  void onInit() {
    super.onInit();
    setKeyDerivationAlgorithm(keyDerivationAlgorithm);
  }

  void generatePbkdf2Salt() {
    pbkdf2SaltInputController.text = _encodeService.convertToEncoding(
      _randomService.generateRandomBytes(16),
      EncodingTypes.base64,
    );
  }

  void generateScryptSalt() {
    scryptSaltInputController.text = _encodeService.convertToEncoding(
      _randomService.generateRandomBytes(16),
      EncodingTypes.base64,
    );
  }

  void processInputs() async {
    if (plaintextFormKey.currentState?.validate() != true) {
      return;
    }

    if (processType == KeyDerivationProcessType.derive &&
        plaintextFormKey.currentState?.validate() != true) {
      return;
    }

    final plaintext = plaintextInputController.text;
    final derivedKey = derivedKeyInputController.text;

    String result = '';

    try {
      switch (keyDerivationAlgorithm) {
        case KeyDerivationAlgorithms.bcrypt:
          if (bcryptRoundsFormKey.currentState?.validate() != true) {
            return;
          }

          if (processType == KeyDerivationProcessType.derive) {
            result = await _keyDerivationService.hashBcrypt(
              plaintext: plaintext,
            );
          } else if (processType == KeyDerivationProcessType.verify) {
            result =
                await _keyDerivationService.verifyBcrypt(
                      plaintext: plaintext,
                      hashed: derivedKey,
                    )
                    ? 'Valid'
                    : 'Invalid';
          }
        case KeyDerivationAlgorithms.pbkdf2:
          if (pbkdf2SaltFormKey.currentState?.validate() != true ||
              pbkdf2KeyLengthFormKey.currentState?.validate() != true ||
              pbkdf2RoundsFormKey.currentState?.validate() != true) {
            return;
          }

          final digest = pbkdf2HashAlgorithm.label;
          final salt = base64.decode(pbkdf2SaltInputController.text);
          final keyLength =
              int.tryParse(pbkdf2KeyLengthInputController.text) ?? 32;
          final rounds =
              int.tryParse(pbkdf2RoundsInputController.text) ?? 100000;

          if (processType == KeyDerivationProcessType.derive) {
            result = base64.encode(
              await _keyDerivationService.deriveKeyPbkdf2(
                plaintext: utf8.encode(plaintext),
                digest: digest,
                salt: salt,
                keyLength: keyLength,
                rounds: rounds,
              ),
            );
          } else if (processType == KeyDerivationProcessType.verify) {
            result =
                await _keyDerivationService.verifyPbkdf2(
                      plaintext: utf8.encode(plaintext),
                      derivedKey: base64.decode(derivedKey),
                      digest: digest,
                      salt: salt,
                      keyLength: keyLength,
                      rounds: rounds,
                    )
                    ? 'Valid'
                    : 'Invalid';
          }
        case KeyDerivationAlgorithms.scrypt:
          if (scryptCostFormKey.currentState?.validate() != true ||
              scryptBlockSizeFormKey.currentState?.validate() != true ||
              scryptParallelismFormKey.currentState?.validate() != true ||
              scryptKeyLengthFormKey.currentState?.validate() != true ||
              scryptSaltFormKey.currentState?.validate() != true) {
            return;
          }

          final cost = int.tryParse(scryptCostInputController.text) ?? 2 ^ 16;
          final blockSize =
              int.tryParse(scryptBlockSizeInputController.text) ?? 8;
          final parallelism =
              int.tryParse(scryptParallelismInputController.text) ?? 1;
          final keyLength =
              int.tryParse(scryptKeyLengthInputController.text) ?? 32;
          final salt = base64.decode(scryptSaltInputController.text);

          if (processType == KeyDerivationProcessType.derive) {
            result = base64.encode(
              await _keyDerivationService.deriveKeyScrypt(
                plaintext: utf8.encode(plaintext),
                N: cost,
                r: blockSize,
                p: parallelism,
                keyLength: keyLength,
                salt: salt,
              ),
            );
          } else if (processType == KeyDerivationProcessType.verify) {
            result =
                await _keyDerivationService.verifyScrypt(
                      plaintext: utf8.encode(plaintext),
                      derivedKey: base64.decode(derivedKey),
                      N: cost,
                      r: blockSize,
                      p: parallelism,
                      keyLength: keyLength,
                      salt: salt,
                    )
                    ? 'Valid'
                    : 'Invalid';
          }
      }

      resultController.text = result;
    } catch (e) {
      resultController.text = 'Processing error';
    }
  }

  void setKeyDerivationAlgorithm(KeyDerivationAlgorithms algorithm) {
    _keyDerivationAlgorithm.value = algorithm;

    derivedKeyFormKey.currentState?.validate();

    switch (algorithm) {
      case KeyDerivationAlgorithms.bcrypt:
        bcryptRoundsInputController.text = '10';
      case KeyDerivationAlgorithms.pbkdf2:
        pbkdf2KeyLengthInputController.text = '32';
        pbkdf2RoundsInputController.text = '1000';
        generatePbkdf2Salt();
      case KeyDerivationAlgorithms.scrypt:
        scryptCostInputController.text = '16384';
        scryptBlockSizeInputController.text = '8';
        scryptParallelismInputController.text = '1';
        scryptKeyLengthInputController.text = '32';
        generateScryptSalt();
    }
  }

  void setPbkdf2HashAlgorithm(HashAlgorithms algorithm) {
    _pbkdf2HashAlgorithm.value = algorithm;
  }

  void setProcessType(KeyDerivationProcessType type) {
    _processType.value = type;
  }

  String? validatePlaintext(String? value) {
    if (value == null || value.isEmpty) {
      return 'Plaintext cannot be empty';
    }

    return null;
  }

  String? validateBcryptRounds(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rounds cannot be empty';
    }

    if (!value.isNumericOnly) {
      return 'Rounds must be a number';
    }

    final intValue = int.parse(value);

    if (intValue < 4 || intValue > 31) {
      return '(log) Rounds must be between 4 and 31';
    }

    return null;
  }

  String? validateDerivedKey(String? value) {
    if (value == null || value.isEmpty) {
      return 'Derived key cannot be empty';
    }

    if (keyDerivationAlgorithm != KeyDerivationAlgorithms.bcrypt &&
        !validateEncoding(value, EncodingTypes.base64)) {
      return 'Derived key must be in Base64';
    }

    return null;
  }

  String? validateKeyLength(String? value) {
    if (value == null || value.isEmpty) {
      return 'Key length cannot be empty';
    }

    if (!value.isNumericOnly) {
      return 'Key length must be a number';
    }

    if (int.parse(value) < 1) {
      return 'Key length must be bigger than 0';
    }

    return null;
  }

  String? validatePbkdf2Rounds(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rounds cannot be empty';
    }

    if (!value.isNumericOnly) {
      return 'Rounds must be a number';
    }

    if (int.parse(value) < 1) {
      return 'Rounds must be bigger than 0';
    }

    return null;
  }

  String? validateSalt(String? value) {
    if (value == null || value.isEmpty) {
      return 'Salt cannot be empty';
    }

    if (!validateEncoding(value, EncodingTypes.base64)) {
      return 'Salt must be in Base64';
    }

    return null;
  }

  String? validateScryptBlockSize(String? value) {
    if (value == null || value.isEmpty) {
      return 'Block size cannot be empty';
    }

    if (!value.isNumericOnly) {
      return 'Block size must be a number';
    }

    if (int.parse(value) < 1) {
      return 'Block size must be bigger than 0';
    }

    return null;
  }

  String? validateScryptCost(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cost cannot be empty';
    }

    if (!value.isNumericOnly) {
      return 'Cost must be a number';
    }

    final intValue = int.parse(value);

    if (intValue < 2) {
      return 'Cost must be bigger than 1';
    }

    if (intValue & (intValue - 1) != 0) {
      return 'Cost must be the power of 2';
    }

    return null;
  }

  String? validateScryptParallelism(String? value) {
    if (value == null || value.isEmpty) {
      return 'Parallelism cannot be empty';
    }

    if (!value.isNumericOnly) {
      return 'Parallelism must be a number';
    }

    if (int.parse(value) < 1) {
      return 'Parallelism must be bigger than 0';
    }

    return null;
  }
}
