import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum KeyDerivationProcessType {
  derive('Derive Key'),
  verify('Verify Key');

  final String label;

  const KeyDerivationProcessType(this.label);
}

class KeyDerivationProcessTypeSelector extends StatelessWidget {
  final KeyDerivationProcessType _selectedType;
  final ValueChanged<KeyDerivationProcessType> _onSelectedTypeChanged;

  const KeyDerivationProcessTypeSelector({
    super.key,
    required KeyDerivationProcessType selectedType,
    required ValueChanged<KeyDerivationProcessType> onSelectedTypeChanged,
  }) : _selectedType = selectedType,
       _onSelectedTypeChanged = onSelectedTypeChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments:
          KeyDerivationProcessType.values
              .map(
                (type) => ButtonSegment(value: type, label: Text(type.label)),
              )
              .toList(),
      selected: {_selectedType},
      onSelectionChanged:
          (newSelectionSet) => _onSelectedTypeChanged(newSelectionSet.first),
      showSelectedIcon: false,
    );
  }
}
