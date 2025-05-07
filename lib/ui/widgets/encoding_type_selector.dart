import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:flutter/material.dart';

class EncodingTypeSelector extends StatelessWidget {
  final EncodingTypes _initialSelection;
  final ValueChanged<EncodingTypes> _onSelected;
  final bool _enabled;
  final List<EncodingTypes> _entries;

  const EncodingTypeSelector({
    super.key,
    required EncodingTypes initialSelection,
    required void Function(EncodingTypes) onSelected,
    bool enabled = true,
    List<EncodingTypes> entries = EncodingTypes.values,
  }) : _initialSelection = initialSelection,
       _onSelected = onSelected,
       _enabled = enabled,
       _entries = entries;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<EncodingTypes>(
      enabled: _enabled,
      label: const Text('Encoding'),
      initialSelection: _initialSelection,
      onSelected: (value) {
        if (value != null) {
          _onSelected(value);
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
