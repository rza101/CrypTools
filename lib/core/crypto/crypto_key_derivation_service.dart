import 'dart:typed_data';

abstract class CryptoKeyDerivationService {
  Future<String> hashBcrypt({
    required String plaintext,
    int logRounds = 10,
    String prefix = '\$2a',
  });

  Future<bool> verifyBcrypt({
    required String plaintext,
    required String hashed,
  });

  Future<Uint8List> deriveKeyPbkdf2({
    required Uint8List plaintext,
    required String digest,
    required Uint8List salt,
    required int keyLength,
    int rounds = 100000,
  });

  Future<bool> verifyPbkdf2({
    required Uint8List plaintext,
    required Uint8List derivedKey,
    required String digest,
    required Uint8List salt,
    required int keyLength,
    int rounds = 100000,
  });

  Future<Uint8List> deriveKeyScrypt({
    required Uint8List plaintext,
    required int N,
    required int r,
    required int p,
    required int keyLength,
    required Uint8List salt,
  });

  Future<bool> verifyScrypt({
    required Uint8List plaintext,
    required Uint8List derivedKey,
    required int N,
    required int r,
    required int p,
    required int keyLength,
    required Uint8List salt,
  });
}
