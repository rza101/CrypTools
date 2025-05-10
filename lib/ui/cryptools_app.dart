import 'package:cryptools/ui/navigation/routes.dart';
import 'package:cryptools/ui/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO hint with info icon button on elements
// TODO improve UI
class CrypToolsApp extends StatelessWidget {
  final ThemeController _themeController = Get.find();

  CrypToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp.router(
        title: 'CrypTools',
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode:
            _themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
