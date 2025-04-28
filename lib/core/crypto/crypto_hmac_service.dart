import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';

abstract class CryptoHMACService {
  String hmacBytes(HashAlgorithms algorithm, List<int> key, List<int> input);

  Future<String> hmacFile(HashAlgorithms algorithm, List<int> key, XFile file);
}
