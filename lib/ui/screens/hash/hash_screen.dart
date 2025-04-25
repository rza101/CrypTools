import 'dart:convert';
import 'dart:io';

import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/default_crypto_hash_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HashScreen extends StatefulWidget {
  HashScreen({super.key});

  final hashService = DefaultCryptoHashService();
  final plaintext = utf8.encode('12345678');

  @override
  State<HashScreen> createState() => _HashScreenState();
}

class _HashScreenState extends State<HashScreen> {
  final Map<String, String> plaintextHashResults = {};
  final Map<String, String> fileHashResults = {};

  @override
  void initState() {
    super.initState();
    _hashPlaintext();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text('Plaintext: 12345678'),
            Text('Hash:'),
            Text(
              plaintextHashResults.entries
                  .toList()
                  .map((entry) => '- ${entry.key}: ${entry.value}')
                  .join('\n'),
            ),
            Divider(height: 1),
            ElevatedButton(
              onPressed: () => _hashFile(),
              child: Text('Select File'),
            ),
            Text(
              fileHashResults.entries
                  .toList()
                  .map((entry) => '- ${entry.key}: ${entry.value}')
                  .join('\n'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _hashPlaintext() async {
    for (final algorithm in HashAlgorithms.values) {
      plaintextHashResults[algorithm.label] = await widget.hashService
          .hashBytes(algorithm, widget.plaintext);

      setState(() {
        plaintextHashResults;
      });
    }
  }

  void _hashFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null || result.files.single.path == null) {
      return;
    }

    setState(() {
      fileHashResults.clear();
    });

    final file = File(result.files.single.path!);

    for (final algorithm in HashAlgorithms.values) {
      fileHashResults[algorithm.label] = await widget.hashService.hashFile(
        algorithm,
        file,
      );
      setState(() {
        fileHashResults;
      });
    }
  }
}
