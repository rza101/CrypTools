import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/default_crypto_hash_service.dart';
import 'package:cryptools/ui/widgets/file_input_container.dart';
import 'package:cryptools/ui/widgets/hash_type_selector.dart';
import 'package:cryptools/ui/widgets/input_type_selector.dart';
import 'package:flutter/material.dart';

// TODO refactor using mvvm
class HashScreen extends StatefulWidget {
  final hashService = DefaultCryptoHashService();

  HashScreen({super.key});

  @override
  State<HashScreen> createState() => _HashScreenState();
}

class _HashScreenState extends State<HashScreen> {
  final _hashResultController = TextEditingController();
  final _hmacKeyInputController = TextEditingController();
  final _textInputController = TextEditingController();

  String? _fileHashResult;
  HashAlgorithms _selectedHashAlgorithm = HashAlgorithms.md5;
  bool _isAutoHash = true;
  bool _isHmacMode = false;
  XFile? _selectedFile;
  InputType _selectedInputType = InputType.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Hash Algorithm',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                HashTypeSelector(
                  initialValue: HashAlgorithms.md5,
                  onSelectedValueChanged: (value) {
                    setState(() {
                      _selectedHashAlgorithm = value;
                      _doAutoHashing();
                    });
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Input Type',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                InputTypeSelector(
                  selectedType: _selectedInputType,
                  onSelectedTypeChanged: (value) {
                    setState(() {
                      _selectedInputType = value;
                      _doAutoHashing();
                    });
                  },
                ),
              ],
            ),
            Row(
              spacing: 4,
              children: [
                Text(
                  'HMAC Mode',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Switch(
                  value: _isHmacMode,
                  onChanged: (value) {
                    setState(() {
                      _isHmacMode = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              spacing: 4,
              children: [
                Text(
                  'Auto Hash',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Switch(
                  value: _isAutoHash && _selectedInputType == InputType.text,
                  onChanged:
                      _selectedInputType == InputType.text
                          ? (value) {
                            setState(() {
                              _isAutoHash = value;
                              _doAutoHashing();
                            });
                          }
                          : null,
                ),
                FilledButton(
                  onPressed:
                      !_isAutoHash || _selectedInputType == InputType.file
                          ? () {
                            _doHashing();
                          }
                          : null,
                  child: Text('Hash'),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: switch (_selectedInputType) {
                InputType.text => TextField(
                  controller: _textInputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Plaintext',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (value) {
                    _doAutoHashing();
                  },
                ),
                InputType.file => FileInputContainer(
                  onFileSet: (file) {
                    _selectedFile = file;
                  },
                ),
              },
            ),
            if (_isHmacMode)
              SizedBox(
                height: 200,
                child: TextField(
                  controller: _hmacKeyInputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'HMAC Key',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  enabled: _isHmacMode,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (value) {
                    _doAutoHashing();
                  },
                ),
              ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _hashResultController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hash Result',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                canRequestFocus: false,
                expands: true,
                minLines: null,
                maxLines: null,
                readOnly: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _doAutoHashing() {
    if (_isAutoHash) {
      _doHashing();
    }
  }

  void _doHashing() {
    switch (_selectedInputType) {
      case InputType.text:
        _hashPlaintext();
      case InputType.file:
        _hashFile();
    }
  }

  void _hashPlaintext() {
    final text = _textInputController.text;

    if (text.isNotEmpty) {
      _hashResultController.text = widget.hashService.hashBytes(
        _selectedHashAlgorithm,
        utf8.encode(text),
      );
    } else {
      _hashResultController.text = '';
    }
  }

  void _hashFile() async {
    final file = _selectedFile;

    _hashResultController.text = '';

    if (file != null) {
      _hashResultController.text = await widget.hashService.hashFile(
        _selectedHashAlgorithm,
        file,
      );
    }
  }
}
