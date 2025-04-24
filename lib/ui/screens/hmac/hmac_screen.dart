import 'dart:convert';

import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/core/crypto/default_crypto_hmac_service.dart';
import 'package:flutter/material.dart';

class HMACScreen extends StatelessWidget {
  HMACScreen({super.key});

  final hmacService = DefaultCryptoHMACService();
  final plaintext = utf8.encode('12345678');
  final hmacKey = utf8.encode('12345678');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text('Plaintext: 12345678, HMAC Key: 12345678')),
        Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: HashAlgorithms.values.length,
            itemBuilder: (ctx, index) {
              final algorithm = HashAlgorithms.values[index];

              return ListTile(
                key: ValueKey(index),
                title: FutureBuilder(
                  future: hmacService.hmacBytes(algorithm, hmacKey, plaintext),
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
