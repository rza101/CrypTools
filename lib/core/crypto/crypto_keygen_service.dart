import 'package:pointycastle/pointycastle.dart';

abstract class CryptoKeygenService {
  Future<AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>> generateRSAKeyPair(
    int keySize,
    SecureRandom randomSource,
  );
}
