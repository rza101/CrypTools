import 'package:cryptools/ui/screens/encrypt/encrypt_controller.dart';
import 'package:cryptools/ui/widgets/loading_wrapper.dart';
import 'package:cryptools/ui/widgets/multiline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EncryptScreen extends StatelessWidget {
  final EncryptController _controller = Get.find();

  EncryptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = SingleChildScrollView(
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

    return Obx(
      () => LoadingWrapper(isLoading: _controller.isLoading, child: screen),
    );
  }
}

class _KeyForm extends StatelessWidget {
  final EncryptController _controller;

  const _KeyForm({required EncryptController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.keyFormKey,
        controller: _controller.keyTextController,
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
      ),
    );
  }
}

class _NonceForm extends StatelessWidget {
  final EncryptController _controller;

  const _NonceForm({required EncryptController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.nonceFormKey,
        controller: _controller.nonceTextController,
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
      ),
    );
  }
}

class _PlaintextForm extends StatelessWidget {
  final EncryptController _controller;

  const _PlaintextForm({required EncryptController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => MultilineTextField(
          formFieldKey: _controller.plaintextFormKey,
          controller: _controller.plaintextTextController,
          labelText: 'Plaintext (UTF-8)',
          validator: _controller.validatePlaintext,
          enabled: !_controller.isLoading,
        ),
      ),
    );
  }
}

class _EncryptDecryptButton extends StatelessWidget {
  final EncryptController _controller;

  const _EncryptDecryptButton({required EncryptController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 24,
      children: [
        Obx(
          () => FilledButton(
            onPressed: !_controller.isLoading ? _controller.aesEncrypt : null,
            child: const Text('Encrypt'),
          ),
        ),
        Obx(
          () => FilledButton(
            onPressed: !_controller.isLoading ? _controller.aesDecrypt : null,
            child: const Text('Decrypt'),
          ),
        ),
      ],
    );
  }
}

class _CiphertextForm extends StatelessWidget {
  final EncryptController _controller;

  const _CiphertextForm({required EncryptController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => MultilineTextField(
          formFieldKey: _controller.ciphertextFormKey,
          controller: _controller.ciphertextTextController,
          labelText: 'Ciphertext (Base64)',
          validator: _controller.validateCiphertext,
          enabled: !_controller.isLoading,
        ),
      ),
    );
  }
}
