import 'package:flutter/material.dart';

class TooltipIcon extends StatelessWidget {
  final String _message;

  const TooltipIcon({super.key, required String message}) : _message = message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(message: _message, child: Icon(Icons.info_outline));
  }
}
