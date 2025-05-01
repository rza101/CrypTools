import 'dart:typed_data';

abstract class CryptoRandomService {
  Uint8List generateRandomBytes(int length);
}
