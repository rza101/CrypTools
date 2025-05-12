import 'package:flutter/material.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget _child;
  final bool _isLoading;

  const LoadingWrapper({
    super.key,
    required Widget child,
    required bool isLoading,
  }) : _child = child,
       _isLoading = isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _child,
        if (_isLoading) Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
