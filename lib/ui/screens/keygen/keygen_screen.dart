import 'package:cryptools/core/extensions.dart';
import 'package:cryptools/ui/screens/keygen/keygen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class KeygenScreen extends StatelessWidget {
  final KeygenController _controller = Get.find();

  KeygenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final publicKeyTextField = SizedBox(
      height: 200,
      child: TextField(
        controller: _controller.publicKeyOutputController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Public Key',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        expands: true,
        minLines: null,
        maxLines: null,
        readOnly: true,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
    final privateKeyTextField = SizedBox(
      height: 200,
      child: TextField(
        controller: _controller.privateKeyOutputController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Private Key',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        expands: true,
        minLines: null,
        maxLines: null,
        readOnly: true,
        textAlignVertical: TextAlignVertical.top,
      ),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Text('Currently only supports RSA key'),
            TextField(
              controller: _controller.rsaKeyLengthInputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Key Length (bits)',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              maxLines: 1,
            ),
            context.isWideScreen()
                ? Row(
                  spacing: 24,
                  children: [
                    Expanded(child: publicKeyTextField),
                    Expanded(child: privateKeyTextField),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [publicKeyTextField, privateKeyTextField],
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
