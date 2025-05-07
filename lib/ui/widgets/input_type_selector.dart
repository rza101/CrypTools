import 'package:flutter/material.dart';

enum InputType {
  text('Text'),
  file('File');

  final String label;

  const InputType(this.label);
}

class InputTypeSelector extends StatelessWidget {
  final bool _enabled;
  final InputType _selectedType;
  final ValueChanged<InputType> _onSelectedTypeChanged;

  const InputTypeSelector({
    super.key,
    required InputType selectedType,
    required void Function(InputType) onSelectedTypeChanged,
    bool enabled = true,
  }) : _enabled = enabled,
       _onSelectedTypeChanged = onSelectedTypeChanged,
       _selectedType = selectedType;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<InputType>(
      segments:
          InputType.values
              .map(
                (type) => ButtonSegment(value: type, label: Text(type.label)),
              )
              .toList(),
      selected: {_selectedType},
      onSelectionChanged:
          _enabled
              ? (newSelectionSet) =>
                  _onSelectedTypeChanged(newSelectionSet.first)
              : null,
      showSelectedIcon: false,
    );
  }
}
