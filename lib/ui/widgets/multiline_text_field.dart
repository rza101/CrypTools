import 'package:flutter/material.dart';

class MultilineTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String _labelText;
  final bool _readOnly;
  final bool _enabled;

  const MultilineTextField({
    super.key,
    required TextEditingController controller,
    required String labelText,
    bool enabled = true,
    bool readOnly = false,
  }) : _controller = controller,
       _labelText = labelText,
       _readOnly = readOnly,
       _enabled = enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: _labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top,
        readOnly: _readOnly,
        maxLines: null,
        minLines: null,
        expands: true,
        enabled: _enabled,
      ),
    );
  }
}
