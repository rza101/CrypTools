import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_encode_service.dart';

class DefaultCryptoEncodeService implements CryptoEncodeService {
  @override
  Uint8List convertToByteArray(String data, EncodingTypes encoding) {
    final Uint8List result;

    switch (encoding) {
      case EncodingTypes.utf8:
        result = utf8.encode(data);
      case EncodingTypes.ascii:
        result = ascii.encode(data);
      case EncodingTypes.base64:
        result = base64.decode(data);
      case EncodingTypes.base64Url:
        result = base64Url.decode(data);
      case EncodingTypes.hex:
        result = Uint8List(data.length ~/ 2);
        for (int i = 0; i < data.length; i += 2) {
          result[i ~/ 2] = int.parse(data.substring(i, i + 2), radix: 16);
        }
    }

    return result;
  }

  @override
  String convertToEncoding(Uint8List bytes, EncodingTypes encoding) {
    return switch (encoding) {
      EncodingTypes.utf8 => utf8.decode(bytes),

      EncodingTypes.ascii => ascii.decode(bytes),

      EncodingTypes.base64 => base64.encode(bytes),

      EncodingTypes.base64Url => base64Url.encode(bytes),

      EncodingTypes.hex =>
        bytes.map((value) => value.toRadixString(16).padLeft(2, '0')).join(),
    };
  }
}
