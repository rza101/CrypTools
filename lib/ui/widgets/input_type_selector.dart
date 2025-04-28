import 'package:flutter/material.dart';

enum InputType {
  text('Text'),
  file('File');

  final String label;

  const InputType(this.label);
}

class InputTypeSelector extends StatelessWidget {
  final InputType selectedType;
  final ValueChanged<InputType> onSelectedTypeChanged;

  const InputTypeSelector({
    super.key,
    required this.selectedType,
    required this.onSelectedTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<InputType>(
      segments: [
        ButtonSegment(value: InputType.text, label: Text(InputType.text.label)),
        ButtonSegment(value: InputType.file, label: Text(InputType.file.label)),
      ],
      selected: {selectedType},
      onSelectionChanged:
          (newSelectionSet) => onSelectedTypeChanged(newSelectionSet.first),
      showSelectedIcon: false,
    );
  }
}
