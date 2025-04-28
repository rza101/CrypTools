import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:cryptools/core/crypto/crypto_key_derivation_service.dart';
import 'package:flutter/foundation.dart';

class DefaultCryptoKeyDerivationService extends CryptoKeyDerivationService {
  @override
  String genSaltBcrypt({
    int logRounds = 10,
    String prefix = '\$2a',
    Random? randomSource,
  }) {
    return BCrypt.gensalt(
      logRounds: logRounds,
      prefix: prefix,
      secureRandom: randomSource,
    );
  }

  @override
  Future<String> hashBcrypt({required String text, String? salt}) async {
    return compute(_hashBcryptSync, {'text': text, 'salt': salt});
  }

  String _hashBcryptSync(Map<String, Object?> args) {
    final text = args['text'] as String;
    final salt = args['salt'] as String?;
    return BCrypt.hashpw(text, salt ?? genSaltBcrypt());
  }

  @override
  Future<bool> checkBcrypt({
    required String hashed,
    required String text,
  }) async {
    return compute(_checkBcryptSync, {'hashed': hashed, 'text': text});
  }

  bool _checkBcryptSync(Map<String, Object?> args) {
    final hashed = args['hashed'] as String;
    final text = args['text'] as String;
    return BCrypt.checkpw(text, hashed);
  }

  // TODO add PBKDF2, scrypt, and argon2
}
