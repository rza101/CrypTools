import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';

class CrypToolsApp extends StatelessWidget {
  const CrypToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "CrypTools",
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
