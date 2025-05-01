import 'dart:math';
import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_random_service.dart';

class DefaultCryptoRandomService implements CryptoRandomService {
  static final _rand = Random.secure();

  @override
  Uint8List generateRandomBytes(int length) {
    return Uint8List.fromList(List.generate(length, (_) => _rand.nextInt(256)));
  }
}
