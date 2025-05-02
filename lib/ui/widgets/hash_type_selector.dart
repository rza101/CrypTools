import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:flutter/material.dart';

class HashTypeSelector extends StatelessWidget {
  final HashAlgorithms _initialSelection;
  final ValueChanged<HashAlgorithms> _onSelectionChanged;

  const HashTypeSelector({
    super.key,
    required HashAlgorithms initialSelection,
    required void Function(HashAlgorithms) onSelectionChanged,
  }) : _onSelectionChanged = onSelectionChanged,
       _initialSelection = initialSelection;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<HashAlgorithms>(
      initialSelection: _initialSelection,
      label: const Text('Hash Algorithm'),
      onSelected: (value) {
        if (value != null) {
          _onSelectionChanged(value);
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
