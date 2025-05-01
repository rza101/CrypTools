import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptools/core/crypto/crypto_encode_service.dart';

class DefaultCryptoEncodeService implements CryptoEncodeService {
  static final asciiRegex = RegExp(r'^[\x00-\x7F]*$');
  static final base64Regex = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
  static final base64UrlRegex = RegExp(r'^[A-Za-z0-9\-_]*={0,2}$');
  static final hexRegex = RegExp(r'^[0-9a-fA-F]*$');

  @override
  Uint8List convertToByteArray(EncodingTypes encoding, String data) {
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
  String convertToEncoding(EncodingTypes encoding, Uint8List bytes) {
    return switch (encoding) {
      EncodingTypes.utf8 => utf8.decode(bytes),

      EncodingTypes.ascii => ascii.decode(bytes),

      EncodingTypes.base64 => base64.encode(bytes),

      EncodingTypes.base64Url => base64Url.encode(bytes),

      EncodingTypes.hex =>
        bytes.map((value) => value.toRadixString(16).padLeft(2, '0')).join(),
    };
  }

  static bool validateEncoding(EncodingTypes encoding, String data) {
    return switch (encoding) {
      EncodingTypes.utf8 => true,

      EncodingTypes.ascii => asciiRegex.hasMatch(data),

      EncodingTypes.base64 =>
        data.length % 4 == 0 && base64Regex.hasMatch(data),

      EncodingTypes.base64Url =>
        data.length % 4 == 0 && base64UrlRegex.hasMatch(data),

      EncodingTypes.hex => data.length % 2 == 0 && hexRegex.hasMatch(data),
    };
  }
}
