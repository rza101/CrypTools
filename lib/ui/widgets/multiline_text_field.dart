import 'package:flutter/material.dart';

class MultilineTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String _labelText;
  final bool _readOnly;
  final bool _enabled;
  final Key? _formFieldKey;
  final String? Function(String?)? _validator;
  final AutovalidateMode? _autovalidateMode;

  const MultilineTextField({
    super.key,
    required TextEditingController controller,
    required String labelText,
    bool readOnly = false,
    bool enabled = true,
    Key? formFieldKey,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
  }) : _controller = controller,
       _labelText = labelText,
       _readOnly = readOnly,
       _enabled = enabled,
       _formFieldKey = formFieldKey,
       _validator = validator,
       _autovalidateMode = autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextFormField(
        key: _formFieldKey,
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
        validator: _validator,
        enabled: _enabled,
        autovalidateMode: _autovalidateMode,
      ),
    );
  }
}
