import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:flutter/material.dart';

class EncodingTypeSelector extends StatelessWidget {
  final ValueChanged<EncodingTypes> _onSelectedTypeChanged;

  const EncodingTypeSelector({
    super.key,
    required void Function(EncodingTypes) onSelectedTypeChanged,
  }) : _onSelectedTypeChanged = onSelectedTypeChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<EncodingTypes>(
      initialSelection: EncodingTypes.utf8,
      onSelected: (value) {
        if (value != null) {
          _onSelectedTypeChanged(value);
        }
      },
      dropdownMenuEntries:
          EncodingTypes.values
              .map(
                (encoding) =>
                    DropdownMenuEntry(value: encoding, label: encoding.label),
              )
              .toList(),
    );
  }
}
