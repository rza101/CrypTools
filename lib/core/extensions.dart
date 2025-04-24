import 'dart:typed_data';

extension BytesConverter on Uint8List {
  String toHexString() =>
      map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
