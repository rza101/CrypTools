import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/crypto_hmac_service.dart';
import 'package:cryptools/core/crypto/crypto_key_derivation_service.dart';
import 'package:cryptools/core/crypto/default_crypto_hash_service.dart';
import 'package:cryptools/core/crypto/default_crypto_hmac_service.dart';
import 'package:cryptools/core/crypto/default_crypto_key_derivation_service.dart';
import 'package:get/get.dart';

class CryptoServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CryptoHashService>(() => DefaultCryptoHashService());
    Get.lazyPut<CryptoHMACService>(() => DefaultCryptoHMACService());
    Get.lazyPut<CryptoKeyDerivationService>(
      () => DefaultCryptoKeyDerivationService(),
    );
  }
}
