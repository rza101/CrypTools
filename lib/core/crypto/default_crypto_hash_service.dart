import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/api.dart';

class DefaultCryptoHashService implements CryptoHashService {
  @override
  String hashBytes(Uint8List bytes, HashAlgorithms algorithm) {
    return Digest(algorithm.label).process(bytes).toHexString();
  }

  @override
  Future<String> hashFile(XFile file, HashAlgorithms algorithm) async {
    return compute(_hashFile, {'file': file, 'algorithm': algorithm});
  }

  Future<String> _hashFile(Map<String, Object?> args) async {
    final algorithm = args['algorithm'] as HashAlgorithms;
    final file = args['file'] as XFile;

    final digest = Digest(algorithm.label);

    await for (final chunk in file.openRead()) {
      digest.update(chunk, 0, chunk.length);
    }

    final output = Uint8List(digest.digestSize);
    digest.doFinal(output, 0);

    return output.toHexString();
  }
}
