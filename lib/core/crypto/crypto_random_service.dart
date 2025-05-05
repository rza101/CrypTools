import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';

abstract class CryptoRandomService {
  Uint8List generateRandomBytes(int length);

  SecureRandom generateFortunaRandomInstance();
}
