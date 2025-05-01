import 'package:flutter/material.dart';

enum InputType {
  text('Text'),
  file('File');

  final String label;

  const InputType(this.label);
}

class InputTypeSelector extends StatelessWidget {
  final InputType _selectedType;
  final ValueChanged<InputType> _onSelectedTypeChanged;

  const InputTypeSelector({
    super.key,
    required InputType selectedType,
    required void Function(InputType) onSelectedTypeChanged,
  }) : _onSelectedTypeChanged = onSelectedTypeChanged,
       _selectedType = selectedType;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<InputType>(
      segments: [
        ButtonSegment(value: InputType.text, label: Text(InputType.text.label)),
        ButtonSegment(value: InputType.file, label: Text(InputType.file.label)),
      ],
      selected: {_selectedType},
      onSelectionChanged:
          (newSelectionSet) => _onSelectedTypeChanged(newSelectionSet.first),
      showSelectedIcon: false,
    );
  }
}
