import 'package:cryptools/di/crypto_service_binding.dart';
import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';

// TODO data validation and error messages
// TODO hint with info icon button on elements
// TODO improve UI
// TODO separate components to widgets
class CrypToolsApp extends StatelessWidget {
  const CrypToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    CryptoServiceBinding().dependencies();
    return MaterialApp.router(
      title: 'CrypTools',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
