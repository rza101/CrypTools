import 'package:cryptools/di/crypto_service_binding.dart';
import 'package:cryptools/di/theme_repository_binding.dart';
import 'package:cryptools/ui/theme/theme_binding.dart';
import 'package:flutter/material.dart';

import 'ui/cryptools_app.dart';

void main() {
  ThemeRepositoryBinding().dependencies();
  CryptoServiceBinding().dependencies();

  ThemeBinding().dependencies();

  runApp(CrypToolsApp());
}
