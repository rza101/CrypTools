import 'package:cryptools/core/crypto/crypto_random_service.dart';
import 'package:get/get.dart';

class RandomController extends GetxController {
  final CryptoRandomService _randomService;

  RandomController({required CryptoRandomService randomService})
    : _randomService = randomService;
}
