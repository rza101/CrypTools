import 'package:flutter/material.dart';

enum KeyDerivationProcessType {
  derive('Derive Key'),
  verify('Verify Key');

  final String label;

  const KeyDerivationProcessType(this.label);
}

class KeyDerivationProcessTypeSelector extends StatelessWidget {
  final KeyDerivationProcessType _selectedType;
  final ValueChanged<KeyDerivationProcessType> _onSelectedTypeChanged;
  final bool _enabled;

  const KeyDerivationProcessTypeSelector({
    super.key,
    required KeyDerivationProcessType selectedType,
    required ValueChanged<KeyDerivationProcessType> onSelectedTypeChanged,
    bool enabled = true,
  }) : _selectedType = selectedType,
       _onSelectedTypeChanged = onSelectedTypeChanged,
       _enabled = enabled;

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
          _enabled
              ? (newSelectionSet) => _onSelectedTypeChanged(
                (newSelectionSet as Set<KeyDerivationProcessType>).first,
              )
              : null,
      showSelectedIcon: false,
    );
  }
}
