import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:pointycastle/api.dart';

class DefaultCryptoHashService implements CryptoHashService {
  @override
  Future<String> hashBytes(HashAlgorithms algorithm, Uint8List input) async {
    return Digest(algorithm.label).process(input).toHexString();
  }

  @override
  Future<String> hashByteStream(
    HashAlgorithms algorithm,
    Stream<Uint8List> stream,
  ) async {
    final digest = Digest(algorithm.label);

    await for (final chunk in stream) {
      digest.update(chunk, 0, chunk.length);
    }

    final output = Uint8List(digest.digestSize);
    digest.doFinal(output, 0);

    return output.toHexString();
  }
}
