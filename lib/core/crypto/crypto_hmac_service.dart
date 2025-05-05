import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';

abstract class CryptoHMACService {
  String hmacBytes({
    required Uint8List bytes,
    required Uint8List key,
    required HashAlgorithms algorithm,
  });

  Future<String> hmacFile({
    required XFile file,
    required Uint8List key,
    required HashAlgorithms algorithm,
  });
}
