import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_hmac_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/api.dart';

class DefaultCryptoHMACService implements CryptoHMACService {
  @override
  String hmacBytes({
    required HashAlgorithms algorithm,
    required List<int> key,
    required List<int> input,
  }) {
    final mac = Mac('${algorithm.label}/HMAC')
      ..init(KeyParameter(Uint8List.fromList(key)));

    return mac.process(Uint8List.fromList(input)).toHexString();
  }

  @override
  Future<String> hmacFile({
    required HashAlgorithms algorithm,
    required List<int> key,
    required XFile file,
  }) async {
    return compute(_hmacFile, {
      'algorithm': algorithm,
      'key': key,
      'file': file,
    });
  }

  Future<String> _hmacFile(Map<String, Object?> args) async {
    final HashAlgorithms algorithm = args['algorithm'] as HashAlgorithms;
    final List<int> key = args['key'] as List<int>;
    final XFile file = args['file'] as XFile;

    final mac = Mac('${algorithm.label}/HMAC')
      ..init(KeyParameter(Uint8List.fromList(key)));

    await for (final chunk in file.openRead()) {
      mac.update(Uint8List.fromList(chunk), 0, chunk.length);
    }

    final output = Uint8List(mac.macSize);
    mac.doFinal(output, 0);

    return output.toHexString();
  }
}
