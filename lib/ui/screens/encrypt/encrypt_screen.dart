import 'package:cryptools/ui/screens/encrypt/encrypt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EncryptScreen extends StatelessWidget {
  final EncryptController _controller = Get.find();

  EncryptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            const Text('Algorithm: AES-GCM'),
            TextField(
              controller: _controller.keyInputController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Key (128/192/256 bits in Base64)',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                  onPressed: _controller.generateRandomKey,
                  icon: Icon(Icons.refresh),
                ),
              ),
              maxLines: 1,
              textAlignVertical: TextAlignVertical.top,
            ),
            TextField(
              controller: _controller.nonceInputController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Nonce (192 bits in Base64)',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                  onPressed: _controller.generateNonce,
                  icon: Icon(Icons.refresh),
                ),
              ),
              maxLines: 1,
              textAlignVertical: TextAlignVertical.top,
            ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.plaintextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Plaintext (UTF-8)',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 24,
              children: [
                FilledButton(
                  onPressed: _controller.aesEncrypt,
                  child: const Text('Encrypt'),
                ),
                FilledButton(
                  onPressed: _controller.aesDecrypt,
                  child: const Text('Decrypt'),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.ciphertextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ciphertext (Base64)',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
