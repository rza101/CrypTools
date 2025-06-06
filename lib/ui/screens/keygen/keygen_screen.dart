import 'package:cryptools/core/extensions.dart';
import 'package:cryptools/ui/screens/keygen/keygen_controller.dart';
import 'package:cryptools/ui/widgets/loading_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class KeygenScreen extends StatelessWidget {
  final KeygenController _controller = Get.find();

  KeygenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Text('Currently only supports RSA key'),
            _KeyLengthField(controller: _controller),
            Obx(
              () => FilledButton(
                onPressed:
                    !_controller.isLoading ? _controller.generateKey : null,
                child: Text('Generate Key'),
              ),
            ),
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
          ],
        ),
      ),
    );

    return Obx(
      () => LoadingWrapper(isLoading: _controller.isLoading, child: screen),
    );
  }
}

class _KeyLengthField extends StatelessWidget {
  final KeygenController _controller;

  const _KeyLengthField({required KeygenController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
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
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _PublicKeyField extends StatelessWidget {
  final KeygenController _controller;

  const _PublicKeyField({required KeygenController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => TextField(
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
          enabled: !_controller.isLoading,
        ),
      ),
    );
  }
}

class _PrivateKeyField extends StatelessWidget {
  final KeygenController _controller;

  const _PrivateKeyField({required KeygenController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => TextField(
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
          enabled: !_controller.isLoading,
        ),
      ),
    );
  }
}
