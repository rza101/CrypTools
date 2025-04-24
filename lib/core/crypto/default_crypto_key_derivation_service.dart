import 'package:bcrypt/bcrypt.dart';
import 'package:cryptools/core/crypto/crypto_key_derivation_service.dart';

class DefaultCryptoKeyDerivationService extends CryptoKeyDerivationService {
  @override
  String genSaltBcrypt({int logRounds = 10, String prefix = '\$2a'}) {
    return BCrypt.gensalt(logRounds: logRounds, prefix: prefix);
  }

  @override
  Future<String> hashBcrypt(String text, {String? salt}) async {
    return BCrypt.hashpw(text, salt ?? genSaltBcrypt());
  }

  @override
  Future<bool> checkBcrypt(String hashed, String text) async {
    return BCrypt.checkpw(text, hashed);
  }
}
