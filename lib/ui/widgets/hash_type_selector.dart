import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:flutter/material.dart';

class HashTypeSelector extends StatelessWidget {
  final HashAlgorithms initialValue;
  final ValueChanged<HashAlgorithms> onSelectedValueChanged;

  const HashTypeSelector({
    super.key,
    required this.initialValue,
    required this.onSelectedValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<HashAlgorithms>(
      initialSelection: initialValue,
      onSelected: (value) {
        if (value != null) {
          onSelectedValueChanged(value);
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
