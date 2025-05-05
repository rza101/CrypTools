import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_hmac_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/api.dart';

class DefaultCryptoHMACService implements CryptoHMACService {
  @override
  String hmacBytes({
    required Uint8List bytes,
    required Uint8List key,
    required HashAlgorithms algorithm,
  }) {
    final mac = Mac('${algorithm.label}/HMAC')..init(KeyParameter(key));

    return mac.process(bytes).toHexString();
  }

  @override
  Future<String> hmacFile({
    required XFile file,
    required Uint8List key,
    required HashAlgorithms algorithm,
  }) async {
    return compute(_hmacFile, {
      'file': file,
      'key': key,
      'algorithm': algorithm,
    });
  }

  Future<String> _hmacFile(Map<String, Object?> args) async {
    final algorithm = args['algorithm'] as HashAlgorithms;
    final key = args['key'] as Uint8List;
    final file = args['file'] as XFile;

    final mac = Mac('${algorithm.label}/HMAC')..init(KeyParameter(key));

    await for (final chunk in file.openRead()) {
      mac.update(chunk, 0, chunk.length);
    }

    final output = Uint8List(mac.macSize);
    mac.doFinal(output, 0);

    return output.toHexString();
  }
}
