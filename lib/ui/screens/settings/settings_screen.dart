import 'package:cryptools/ui/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeController _themeController = Get.find();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => SwitchListTile(
            value: _themeController.isDarkMode,
            onChanged: _themeController.setDarkMode,
            title: const Text('Dark Mode'),
          ),
        ),
      ],
    );
  }
}
