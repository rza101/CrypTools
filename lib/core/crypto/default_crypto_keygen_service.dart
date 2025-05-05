import 'package:cryptools/core/crypto/crypto_keygen_service.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart';

class DefaultCryptoKeygenService implements CryptoKeygenService {
  @override
  Future<AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>> generateRSAKeyPair(
    int keySize,
    SecureRandom randomSource,
  ) async {
    return compute(_generateRSAKeyPair, {
      'keySize': keySize,
      'randomSource': randomSource,
    });
  }

  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> _generateRSAKeyPair(
    Map<String, Object?> args,
  ) {
    final keySize = args['keySize'] as int;
    final randomSource = args['randomSource'] as SecureRandom;

    final keyParams = RSAKeyGeneratorParameters(
      BigInt.parse('65537'),
      keySize,
      64,
    );
    final keyGenerator =
        RSAKeyGenerator()..init(ParametersWithRandom(keyParams, randomSource));

    return keyGenerator.generateKeyPair();
  }
}
