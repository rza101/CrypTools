import 'package:bcrypt/bcrypt.dart';
import 'package:cryptools/core/crypto/crypto_key_derivation_service.dart';
import 'package:cryptools/core/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/pointycastle.dart';

class DefaultCryptoKeyDerivationService extends CryptoKeyDerivationService {
  @override
  Future<String> hashBcrypt({
    required String plaintext,
    int logRounds = 10,
    String prefix = '\$2a',
  }) async {
    return compute(_hashBcryptSync, {
      'plaintext': plaintext,
      'logRounds': logRounds,
      'prefix': prefix,
    });
  }

  String _hashBcryptSync(Map<String, Object?> args) {
    final plaintext = args['plaintext'] as String;
    final logRounds = args['logRounds'] as int;
    final prefix = args['prefix'] as String;

    return BCrypt.hashpw(
      plaintext,
      BCrypt.gensalt(logRounds: logRounds, prefix: prefix),
    );
  }

  @override
  Future<bool> verifyBcrypt({
    required String plaintext,
    required String hashed,
  }) async {
    return compute(_verifyBcryptSync, {
      'hashed': hashed,
      'plaintext': plaintext,
    });
  }

  bool _verifyBcryptSync(Map<String, Object?> args) {
    final hashed = args['hashed'] as String;
    final plaintext = args['plaintext'] as String;
    return BCrypt.checkpw(plaintext, hashed);
  }

  @override
  Future<Uint8List> deriveKeyPbkdf2({
    required Uint8List plaintext,
    required String digest,
    required Uint8List salt,
    required int keyLength,
    int rounds = 100000,
  }) async {
    return compute(_deriveKeyPbkdf2, {
      'plaintext': plaintext,
      'digest': digest,
      'salt': salt,
      'keyLength': keyLength,
      'rounds': rounds,
    });
  }

  Uint8List _deriveKeyPbkdf2(Map<String, Object?> args) {
    final plaintext = args['plaintext'] as Uint8List;
    final digest = args['digest'] as String;
    final salt = args['salt'] as Uint8List;
    final keyLength = args['keyLength'] as int;
    final rounds = args['rounds'] as int;

    final pbkdf2 = KeyDerivator('$digest/HMAC/PBKDF2')..init(
      Pbkdf2Parameters(
        salt, // randomly generated but fillable
        rounds, // rounds >= 100k
        keyLength, // key len, for example 32 for aes-256
      ),
    );

    return pbkdf2.process(plaintext);
  }

  @override
  Future<bool> verifyPbkdf2({
    required Uint8List plaintext,
    required Uint8List derivedKey,
    required String digest,
    required Uint8List salt,
    required int keyLength,
    int rounds = 100000,
  }) async {
    final recalculatedKey = await deriveKeyPbkdf2(
      plaintext: plaintext,
      digest: digest,
      salt: salt,
      keyLength: keyLength,
      rounds: rounds,
    );

    return constantTimeEquals(derivedKey, recalculatedKey);
  }

  @override
  Future<Uint8List> deriveKeyScrypt({
    required Uint8List plaintext,
    required int N,
    required int r,
    required int p,
    required int keyLength,
    required Uint8List salt,
  }) {
    return compute(_deriveKeyScrypt, {
      'plaintext': plaintext,
      'N': N,
      'r': r,
      'p': p,
      'keyLength': keyLength,
      'salt': salt,
    });
  }

  Uint8List _deriveKeyScrypt(Map<String, Object?> args) {
    final plaintext = args['plaintext'] as Uint8List;
    final N = args['N'] as int;
    final r = args['r'] as int;
    final p = args['p'] as int;
    final keyLength = args['keyLength'] as int;
    final salt = args['salt'] as Uint8List;

    final scrypt = KeyDerivator('scrypt')
      ..init(ScryptParameters(N, r, p, keyLength, salt));

    return scrypt.process(plaintext);
  }

  @override
  Future<bool> verifyScrypt({
    required Uint8List plaintext,
    required Uint8List derivedKey,
    required int N,
    required int r,
    required int p,
    required int keyLength,
    required Uint8List salt,
  }) async {
    final recalculatedKey = await deriveKeyScrypt(
      plaintext: plaintext,
      N: N,
      r: r,
      p: p,
      keyLength: keyLength,
      salt: salt,
    );

    return constantTimeEquals(derivedKey, recalculatedKey);
  }
}
