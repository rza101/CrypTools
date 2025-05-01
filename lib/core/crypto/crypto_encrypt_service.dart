import 'dart:typed_data';

abstract class CryptoEncryptService {
  Uint8List aesEncrypt({
    required Uint8List key,
    required Uint8List nonce,
    required Uint8List plaintext,
    Uint8List? aad,
  });

  Uint8List aesDecrypt({
    required Uint8List key,
    required Uint8List nonce,
    required Uint8List ciphertext,
    Uint8List? aad,
  });
}
