import 'package:cryptools/ui/screens/encrypt/encrypt_controller.dart';
import 'package:cryptools/ui/widgets/multiline_text_field.dart';
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
            const Text('Currently only supports AES-GCM'),
            _KeyForm(controller: _controller),
            _NonceForm(controller: _controller),
            _PlaintextForm(controller: _controller),
            _EncryptDecryptButton(controller: _controller),
            _CiphertextForm(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class _KeyForm extends StatelessWidget {
  const _KeyForm({required EncryptController controller})
    : _controller = controller;

  final EncryptController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _controller.keyFormKey,
      controller: _controller.keyInputController,
      decoration: InputDecoration(
        labelText:
            'Key (128/192/256 bits in Base64, random generated key = 256 bits)',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: _controller.generateKey,
          icon: Icon(Icons.refresh),
        ),
        border: const OutlineInputBorder(),
      ),
      textAlignVertical: TextAlignVertical.top,
      maxLines: 1,
      validator: _controller.validateKey,
      enabled: !_controller.isLoading,
      autovalidateMode: AutovalidateMode.always,
    );
  }
}

class _NonceForm extends StatelessWidget {
  const _NonceForm({required EncryptController controller})
    : _controller = controller;

  final EncryptController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _controller.nonceFormKey,
      controller: _controller.nonceInputController,
      decoration: InputDecoration(
        labelText: 'Nonce (192 bits in Base64)',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: _controller.generateNonce,
          icon: Icon(Icons.refresh),
        ),
        border: const OutlineInputBorder(),
      ),
      textAlignVertical: TextAlignVertical.top,
      maxLines: 1,
      validator: _controller.validateNonce,
      enabled: !_controller.isLoading,
      autovalidateMode: AutovalidateMode.always,
    );
  }
}

class _PlaintextForm extends StatelessWidget {
  const _PlaintextForm({required EncryptController controller})
    : _controller = controller;

  final EncryptController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: MultilineTextField(
        formFieldKey: _controller.plaintextFormKey,
        controller: _controller.plaintextController,
        labelText: 'Plaintext (UTF-8)',
        validator: _controller.validatePlaintext,
      ),
    );
  }
}

class _EncryptDecryptButton extends StatelessWidget {
  const _EncryptDecryptButton({required EncryptController controller})
    : _controller = controller;

  final EncryptController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _CiphertextForm extends StatelessWidget {
  const _CiphertextForm({required EncryptController controller})
    : _controller = controller;

  final EncryptController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: MultilineTextField(
        formFieldKey: _controller.ciphertextFormKey,
        controller: _controller.ciphertextController,
        labelText: 'Ciphertext (Base64)',
        validator: _controller.validateCiphertext,
      ),
    );
  }
}
