import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:flutter/material.dart';

class HashTypeSelector extends StatelessWidget {
  final HashAlgorithms _initialValue;
  final ValueChanged<HashAlgorithms> _onSelectedValueChanged;

  const HashTypeSelector({
    super.key,
    required HashAlgorithms initialValue,
    required void Function(HashAlgorithms) onSelectedValueChanged,
  }) : _onSelectedValueChanged = onSelectedValueChanged,
       _initialValue = initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<HashAlgorithms>(
      initialSelection: _initialValue,
      onSelected: (value) {
        if (value != null) {
          _onSelectedValueChanged(value);
        }
      },
      dropdownMenuEntries:
          HashAlgorithms.values
              .map(
                (algorithm) =>
                    DropdownMenuEntry(value: algorithm, label: algorithm.label),
              )
              .toList(),
    );
  }
}
