import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_hmac_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:pointycastle/api.dart';

class DefaultCryptoHMACService implements CryptoHMACService {
  @override
  Future<String> hmacBytes(
    HashAlgorithms algorithm,
    Uint8List key,
    Uint8List bytes,
  ) async {
    final mac = Mac('${algorithm.label}/HMAC')..init(KeyParameter(key));
    return mac.process(bytes).toHexString();
  }

  @override
  Future<String> hmacByteStream(
    HashAlgorithms algorithm,
    Uint8List key,
    Stream<Uint8List> stream,
  ) async {
    final mac = Mac('${algorithm.label}/HMAC')..init(KeyParameter(key));

    await for (final chunk in stream) {
      mac.update(chunk, 0, chunk.length);
    }

    final output = Uint8List(mac.macSize);
    mac.doFinal(output, 0);

    return output.toHexString();
  }
}
