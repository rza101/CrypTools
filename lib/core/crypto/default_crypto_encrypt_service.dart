import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_encrypt_service.dart';
import 'package:pointycastle/export.dart';

class DefaultCryptoEncryptService implements CryptoEncryptService {
  static const _aesGcmTagLength = 128;

  @override
  Uint8List aesDecrypt({
    required Uint8List ciphertext,
    required Uint8List key,
    required Uint8List nonce,
    Uint8List? aad,
  }) {
    final aesGcm = GCMBlockCipher(AESEngine());
    final params = AEADParameters(
      KeyParameter(key),
      _aesGcmTagLength,
      nonce,
      aad ?? Uint8List(0),
    );

    aesGcm.init(false, params);

    return aesGcm.process(ciphertext);
  }

  @override
  Uint8List aesEncrypt({
    required Uint8List plaintext,
    required Uint8List key,
    required Uint8List nonce,
    Uint8List? aad,
  }) {
    final aesGcm = GCMBlockCipher(AESEngine());
    final params = AEADParameters(
      KeyParameter(key),
      _aesGcmTagLength,
      nonce,
      aad ?? Uint8List(0),
    );

    aesGcm.init(true, params);

    return aesGcm.process(plaintext);
  }
}
