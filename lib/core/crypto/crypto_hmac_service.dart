import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';

abstract class CryptoHMACService {
  String hmacBytes({
    required HashAlgorithms algorithm,
    required List<int> key,
    required List<int> bytes,
  });

  Future<String> hmacFile({
    required HashAlgorithms algorithm,
    required List<int> key,
    required XFile file,
  });
}
