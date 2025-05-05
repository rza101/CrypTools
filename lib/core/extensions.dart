import 'dart:typed_data';

import 'package:flutter/widgets.dart';

extension ScreenSizeUtil on BuildContext {
  bool isWideScreen() => MediaQuery.sizeOf(this).width >= 600;
}

extension BytesConverter on Uint8List {
  String toHexString() =>
      map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
