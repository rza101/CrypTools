import 'dart:typed_data';

enum EncodingTypes {
  utf8('UTF-8'),
  ascii('ASCII'),
  base64('Base64'),
  base64Url('Base64Url'),
  hex('Hexadecimal');

  final String label;

  const EncodingTypes(this.label);
}

abstract class CryptoEncodeService {
  Uint8List convertToByteArray(String data, EncodingTypes encoding);

  String convertToEncoding(Uint8List bytes, EncodingTypes encoding);
}
