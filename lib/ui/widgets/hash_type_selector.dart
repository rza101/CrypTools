import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:flutter/material.dart';

class HashTypeSelector extends StatelessWidget {
  final HashAlgorithms _initialSelection;
  final ValueChanged<HashAlgorithms> _onSelected;
  final bool _enabled;
  final List<HashAlgorithms> _entries;

  const HashTypeSelector({
    super.key,
    required HashAlgorithms initialSelection,
    required void Function(HashAlgorithms) onSelected,
    bool enabled = true,
    List<HashAlgorithms> entries = HashAlgorithms.values,
  }) : _onSelected = onSelected,
       _initialSelection = initialSelection,
       _enabled = enabled,
       _entries = entries;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<HashAlgorithms>(
      enabled: _enabled,
      label: const Text('Hash Algorithm'),
      initialSelection: _initialSelection,
      onSelected: (value) {
        if (value != null) {
          _onSelected(value);
        }
      },
      dropdownMenuEntries:
          _entries
              .map(
                (algorithm) =>
                    DropdownMenuEntry(value: algorithm, label: algorithm.label),
              )
              .toList(),
    );
  }
}
