import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:flutter/material.dart';

class EncodingTypeSelector extends StatelessWidget {
  final List<EncodingTypes> _entries;
  final EncodingTypes _initialSelection;
  final ValueChanged<EncodingTypes> _onSelectedTypeChanged;

  const EncodingTypeSelector({
    super.key,
    required void Function(EncodingTypes) onSelectedTypeChanged,
    required EncodingTypes initialSelection,
    List<EncodingTypes> entries = EncodingTypes.values,
  }) : _entries = entries,
       _initialSelection = initialSelection,
       _onSelectedTypeChanged = onSelectedTypeChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<EncodingTypes>(
      initialSelection: _initialSelection,
      label: const Text('Encoding'),
      onSelected: (value) {
        if (value != null) {
          _onSelectedTypeChanged(value);
        }
      },
      dropdownMenuEntries:
          _entries
              .map(
                (encoding) =>
                    DropdownMenuEntry(value: encoding, label: encoding.label),
              )
              .toList(),
    );
  }
}
