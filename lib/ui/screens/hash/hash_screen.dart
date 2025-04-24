import 'dart:convert';

import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/default_crypto_hash_service.dart';
import 'package:flutter/material.dart';

class HashScreen extends StatelessWidget {
  HashScreen({super.key});

  final hashService = DefaultCryptoHashService();
  final plaintext = utf8.encode('12345678');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text('Plaintext: 12345678')),
        Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: HashAlgorithms.values.length,
            itemBuilder: (ctx, index) {
              final algorithm = HashAlgorithms.values[index];

              return ListTile(
                key: ValueKey(index),
                title: FutureBuilder(
                  future: hashService.hashBytes(algorithm, plaintext),
                  builder: (ctx, result) {
                    return Text('${algorithm.label}: ${result.data}');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
