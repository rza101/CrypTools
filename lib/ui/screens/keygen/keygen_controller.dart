import 'package:cryptools/core/crypto/crypto_keygen_service.dart';
import 'package:get/get.dart';

class KeygenController extends GetxController {
  final CryptoKeygenService _keygenService;

  KeygenController({required CryptoKeygenService keygenService})
    : _keygenService = keygenService;
}
