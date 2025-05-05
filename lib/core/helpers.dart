import 'dart:typed_data';

bool constantTimeEquals(Uint8List a, Uint8List b) {
  if (a.length != b.length) {
    return false;
  }

  int diff = 0;

  for (int i = 0; i < a.length; i++) {
    diff |= a[i] ^ b[i];
  }

  return diff == 0;
}
