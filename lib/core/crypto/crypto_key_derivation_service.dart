abstract class CryptoKeyDerivationService {
  String genSaltBcrypt({int logRounds = 10, String prefix = '\$2a'});

  Future<String> hashBcrypt({required String text, String? salt});

  Future<bool> checkBcrypt({required String hashed, required String text});
}
