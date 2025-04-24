import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';

class CrypToolsApp extends StatelessWidget {
  const CrypToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CrypTools',
      theme: ThemeData(
        // TODO fix appbar changing color when scrolled
        // although almost fixed by this configuration
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
