import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_hash_service.dart';

abstract class CryptoHMACService {
  Future<String> hmacBytes(
    HashAlgorithms algorithm,
    Uint8List key,
    Uint8List bytes,
  );

  Future<String> hmacByteStream(
    HashAlgorithms algorithm,
    Uint8List key,
    Stream<Uint8List> stream,
  );
}
