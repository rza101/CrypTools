import 'dart:convert';

import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_key_derivation_service.dart';
import 'package:cryptools/core/crypto/crypto_random_service.dart';
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
    final plaintext = plaintextInputController.text;
    final derivedKey = derivedKeyInputController.text;

    String result = '';

    try {
      switch (keyDerivationAlgorithm) {
        case KeyDerivationAlgorithms.bcrypt:
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
          final digest = pbkdf2HashAlgorithm.label;
          final salt = base64.decode(pbkdf2SaltInputController.text);
          final keyLength =
              int.tryParse(pbkdf2KeyLengthInputController.text) ?? 32;
          final rounds =
              int.tryParse(pbkdf2RoundsInputController.text) ?? 100000;

          print(
            '$digest, ${pbkdf2SaltInputController.text}, $keyLength, $rounds, $derivedKey',
          );

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
  }

  void setPbkdf2HashAlgorithm(HashAlgorithms algorithm) {
    _pbkdf2HashAlgorithm.value = algorithm;
  }

  void setProcessType(KeyDerivationProcessType type) {
    _processType.value = type;
  }
}
