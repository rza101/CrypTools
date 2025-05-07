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
  final ValueChanged<KeyDerivationAlgorithms> _onSelected;
  final bool _enabled;

  const KeyDerivationAlgorithmSelector({
    super.key,
    required KeyDerivationAlgorithms initialSelection,
    required ValueChanged<KeyDerivationAlgorithms> onSelected,
    bool enabled = true,
  }) : _initialSelection = initialSelection,
       _onSelected = onSelected,
       _enabled = enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<KeyDerivationAlgorithms>(
      enabled: _enabled,
      label: const Text('Algorithm'),
      initialSelection: _initialSelection,
      onSelected: (value) {
        if (value != null) {
          _onSelected(value);
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
