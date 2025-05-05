import 'dart:math';
import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_random_service.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class DefaultCryptoRandomService implements CryptoRandomService {
  static final _rand = Random.secure();

  @override
  Uint8List generateRandomBytes(int length) {
    return Uint8List.fromList(List.generate(length, (_) => _rand.nextInt(256)));
  }

  @override
  SecureRandom generateFortunaRandomInstance() {
    final secureRandom = FortunaRandom();
    final seed = Uint8List(32);

    for (int i = 0; i < seed.length; i++) {
      seed[i] = _rand.nextInt(256);
    }

    secureRandom.seed(KeyParameter(seed));
    return secureRandom;
  }
}
