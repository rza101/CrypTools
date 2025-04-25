import 'dart:io';

import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/api.dart';

class DefaultCryptoHashService implements CryptoHashService {
  @override
  Future<String> hashBytes(HashAlgorithms algorithm, List<int> input) async {
    return compute(_hashBytesSync, {'algorithm': algorithm, 'input': input});
  }

  String _hashBytesSync(Map<String, Object?> args) {
    final HashAlgorithms algorithm = args['algorithm'] as HashAlgorithms;
    final List<int> input = args['input'] as List<int>;
    return Digest(
      algorithm.label,
    ).process(Uint8List.fromList(input)).toHexString();
  }

  @override
  Future<String> hashFile(HashAlgorithms algorithm, File file) async {
    return compute(_hashFile, {'algorithm': algorithm, 'file': file});
  }

  Future<String> _hashFile(Map<String, Object?> args) async {
    final HashAlgorithms algorithm = args['algorithm'] as HashAlgorithms;
    final File file = args['file'] as File;

    final digest = Digest(algorithm.label);

    await for (final chunk in file.openRead()) {
      digest.update(Uint8List.fromList(chunk), 0, chunk.length);
    }

    final output = Uint8List(digest.digestSize);
    digest.doFinal(output, 0);

    return output.toHexString();
  }
}
