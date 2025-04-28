import 'dart:math';

import 'package:cryptools/core/crypto/default_crypto_key_derivation_service.dart';
import 'package:flutter/material.dart';

class KeyDerivationScreen extends StatefulWidget {
  KeyDerivationScreen({super.key});

  final kdService = DefaultCryptoKeyDerivationService();
  final random = Random(42);

  @override
  State<KeyDerivationScreen> createState() => _KeyDerivationScreenState();
}

class _KeyDerivationScreenState extends State<KeyDerivationScreen> {
  static const plaintext = '12345678';

  late String seededSalt;
  late String randomSalt;
  String? hash;

  @override
  void initState() {
    super.initState();
    seededSalt = widget.kdService.genSaltBcrypt(randomSource: widget.random);
    randomSalt = widget.kdService.genSaltBcrypt();
    _calculateHash();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text('bcrypt salt (with seed): $seededSalt')),
        ListTile(title: Text('bcrypt salt (random): $randomSalt')),
        ListTile(title: Text('bcrypt hash: ${hash ?? 'Calculating'}')),
      ],
    );
  }

  Future<void> _calculateHash() async {
    final hashResult = await widget.kdService.hashBcrypt(
      text: plaintext,
      salt: widget.kdService.genSaltBcrypt(logRounds: 10),
    );
    setState(() {
      hash = hashResult;
    });
  }
}
