import 'package:cryptools/core/extensions.dart';
import 'package:cryptools/ui/screens/keygen/keygen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// TODO loading progress
class KeygenScreen extends StatelessWidget {
  final KeygenController _controller = Get.find();

  KeygenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Text('Currently only supports RSA key'),
            _KeyLengthField(controller: _controller),
            context.isWideScreen()
                ? Row(
                  spacing: 24,
                  children: [
                    Expanded(child: _PublicKeyField(controller: _controller)),
                    Expanded(child: _PrivateKeyField(controller: _controller)),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    _PublicKeyField(controller: _controller),
                    _PrivateKeyField(controller: _controller),
                  ],
                ),
            FilledButton(
              onPressed: _controller.generateKey,
              child: Text('Generate Key'),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyLengthField extends StatelessWidget {
  const _KeyLengthField({required KeygenController controller})
    : _controller = controller;

  final KeygenController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _controller.keyLengthFormKey,
      controller: _controller.rsaKeyLengthInputController,
      decoration: const InputDecoration(
        labelText: 'Key Length (bits)',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: _controller.validateKeyLength,
      autovalidateMode: AutovalidateMode.always,
    );
  }
}

class _PublicKeyField extends StatelessWidget {
  const _PublicKeyField({required KeygenController controller})
    : _controller = controller;

  final KeygenController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: _controller.publicKeyOutputController,
        decoration: const InputDecoration(
          labelText: 'Public Key',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top,
        readOnly: true,
        maxLines: null,
        minLines: null,
        expands: true,
      ),
    );
  }
}

class _PrivateKeyField extends StatelessWidget {
  const _PrivateKeyField({required KeygenController controller})
    : _controller = controller;

  final KeygenController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: _controller.privateKeyOutputController,
        decoration: const InputDecoration(
          labelText: 'Private Key',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top,
        readOnly: true,
        maxLines: null,
        minLines: null,
        expands: true,
      ),
    );
  }
}
