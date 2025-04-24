abstract class CryptoKeyDerivationService {
  String genSaltBcrypt({int logRounds = 10, String prefix = '\$2a'});

  Future<String> hashBcrypt(String text, {String? salt});

  Future<bool> checkBcrypt(String hashed, String text);
}
