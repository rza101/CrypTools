import 'package:flutter/material.dart';

enum KeyDerivationAlgorithms {
  bcrypt('bcrypt'),
  pbkdf2('PBKDF2'),
  scrypt('scrypt');

  final String label;

  const KeyDerivationAlgorithms(this.label);
}

class KeyDerivationAlgorithmSelector extends StatelessWidget {
  final KeyDerivationAlgorithms _initialSelection;
  final ValueChanged<KeyDerivationAlgorithms> _onSelectedTypeChanged;

  const KeyDerivationAlgorithmSelector({
    super.key,
    required KeyDerivationAlgorithms initialSelection,
    required ValueChanged<KeyDerivationAlgorithms> onSelectedTypeChanged,
  }) : _initialSelection = initialSelection,
       _onSelectedTypeChanged = onSelectedTypeChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<KeyDerivationAlgorithms>(
      initialSelection: _initialSelection,
      label: const Text('Algorithm'),
      onSelected: (value) {
        if (value != null) {
          _onSelectedTypeChanged(value);
        }
      },
      dropdownMenuEntries:
          KeyDerivationAlgorithms.values
              .map(
                (encoding) =>
                    DropdownMenuEntry(value: encoding, label: encoding.label),
              )
              .toList(),
    );
  }
}
