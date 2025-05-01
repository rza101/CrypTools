import 'package:cryptools/core/crypto/crypto_key_derivation_service.dart';
import 'package:get/get.dart';

class KeyDerivationController extends GetxController {
  final CryptoKeyDerivationService _keyDerivationService;

  KeyDerivationController({
    required CryptoKeyDerivationService keyDerivationService,
  }) : _keyDerivationService = keyDerivationService;
}
