import 'dart:typed_data';

import 'package:cryptools/core/constants.dart';
import 'package:cryptools/core/crypto/crypto_encode_service.dart';

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

bool validateEncoding(String data, EncodingTypes encoding) {
  return switch (encoding) {
    EncodingTypes.utf8 => true,

    EncodingTypes.ascii => asciiRegex.hasMatch(data),

    EncodingTypes.base64 => data.length % 4 == 0 && base64Regex.hasMatch(data),

    EncodingTypes.base64Url =>
      data.length % 4 == 0 && base64UrlRegex.hasMatch(data),

    EncodingTypes.hex => data.length % 2 == 0 && hexRegex.hasMatch(data),
  };
}
